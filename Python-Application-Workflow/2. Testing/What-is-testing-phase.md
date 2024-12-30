## 2. Testing Phase

### Key Tasks:

 - Write unit tests to ensure code functionality.
 - Write integration tests to test how components interact.
 - Use tools like pytest and unittest for testing.
 
### Example: Test with Pytest:  

 ```python

 # test_app.py
 from app import app
 def test_home():
    response = app.test_client().get('/')
    assert response.status_code == 200
 ```

### Dependencies to Learn:

 - pytest for testing.
 - Test coverage tools (e.g., coverage).
 - Mocking external APIs with responses or unittest.mock.