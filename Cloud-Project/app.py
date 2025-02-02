from flask import Flask, render_template, request
import graphviz
import os

app = Flask(__name__)

# Function to select AWS services based on user inputs
def select_services(application_type, traffic, database_type):
    services = []
    
    if application_type == "Microservices":
        services.append("EKS or ECS")
    elif application_type == "Serverless":
        services.append("AWS Lambda")
    else:
        services.append("EC2 or ECS")
    
    if traffic == "High":
        services.append("ALB + Auto Scaling + CloudFront")
    
    if database_type == "SQL":
        services.append("RDS or Aurora")
    elif database_type == "NoSQL":
        services.append("DynamoDB")
    
    return services

# Function to generate architecture diagram
def generate_diagram(services):
    try:
        dot = graphviz.Digraph(format='png')
        dot.attr(bgcolor='white')
        
        dot.node("User", "User", shape="ellipse", style="filled", fillcolor="lightblue")
        
        for service in services:
            dot.node(service, service, shape="box", style="filled", fillcolor="lightgray")
            dot.edge("User", service)
        
        filename = "static/aws_architecture"
        dot.render(filename)
        return filename + ".png"
    except Exception as e:
        print("Graphviz Error:", e)
        return None

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        # Get form inputs
        application_type = request.form.get("application_type")
        traffic = request.form.get("traffic")
        database_type = request.form.get("database_type")
        
        # Get recommended services
        services = select_services(application_type, traffic, database_type)
        
        # Generate diagram
        diagram_path = generate_diagram(services)
        
        return render_template("result.html", services=services, diagram=diagram_path, show_diagram=False)
    
    return render_template("index.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=4001, debug=True)
