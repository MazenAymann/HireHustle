from flask import Flask
from flask_cors import CORS

from extract_info import my_extract_info
from semantic_similarity import my_semantic_similarity
from text_similarity import my_text_similarity
from interview_scheduling import my_send_confirmation_email

# Create a Flask app object
app = Flask(__name__)
CORS(app)

# Register the blueprint with the app
app.register_blueprint(my_extract_info)
app.register_blueprint(my_semantic_similarity)
app.register_blueprint(my_text_similarity)
app.register_blueprint(my_send_confirmation_email)

# Start the app
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
