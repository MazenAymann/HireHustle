import PyPDF2
from sklearn.metrics.pairwise import cosine_similarity
import nltk
from nltk.tokenize import word_tokenize
import tensorflow_hub as hub
import numpy as np
from flask import Blueprint, request, jsonify
import requests
import io

my_semantic_similarity = Blueprint('my_semantic_similarity', __name__)

nltk.download('punkt')

module_url = "https://tfhub.dev/google/universal-sentence-encoder/4"
model = hub.load(module_url)


def extract_text_from_url(url):
    response = requests.get(url)
    pdf_file = io.BytesIO(response.content)

    pdf_reader = PyPDF2.PdfReader(pdf_file)
    pdf_text = ""

    # Iterate over each page in the PDF
    for page_num in range(len(pdf_reader.pages)):
        # Extract the text from the page and append it to the string
        page = pdf_reader.pages[page_num]
        pdf_text += page.extract_text()

    return pdf_text


def filter_text(text):
    # Tokenize the text into individual words
    tokens = word_tokenize(text)

    # Join the filtered tokens back into a single string
    filtered_text = ' '.join(tokens)

    # Remove extra whitespaces
    filtered_text = ' '.join(filtered_text.split())

    return filtered_text


def extract_text_from_pdf(file):
    text = ""

    # Create a PDF reader object
    pdf_reader = PyPDF2.PdfReader(file)

    # Iterate over each page in the PDF
    for page_num in range(len(pdf_reader.pages)):
        # Extract the text from the page and append it to the string
        page = pdf_reader.pages[page_num]
        text += page.extract_text()

    return text


def extract_text_from_text(file_path):
    # Open the file in read mode
    with open(file_path, 'r', encoding='utf-8') as file:
        # Read the entire contents of the file as a string
        text = file.read()

    # return the text
    return text


def json_to_dictionary(data):
    my_dict = {}  # create an empty dictionary
    for key, value in data.items():
        my_dict[key] = value

    return my_dict


def calc_semantic(cv_text, job_description_text):
    # Encode the CV text and job description text into document embeddings
    cv_embedding = np.array(model([cv_text])[0])
    job_embedding = np.array(model([job_description_text])[0])

    # Calculate cosine similarity between the document embeddings
    similarity_score = cosine_similarity(cv_embedding.reshape(1, -1), job_embedding.reshape(1, -1))[0][0]

    return similarity_score


@my_semantic_similarity.route("/semantic-similarity", methods=["GET", "POST"])
def semantic_similarity():
    if request.method == "POST":
        json = request.get_json()

        if json is None or json == "":
            return jsonify({"error": "No input provided"})

        try:
            # Change JSON to dictionary
            applicants_dict = json_to_dictionary(json)

            job_description_text = applicants_dict['job_description']

            data = {}
            for key, value in applicants_dict['cvs'].items():
                # Extract text from the CV download url
                cv_text = extract_text_from_url(value)

                # Calculate the semantic similarity
                semantic_sim = calc_semantic(cv_text, job_description_text)

                data[key] = round(float(semantic_sim)*100, 3)

            return jsonify(data)

        except Exception as e:
            return jsonify({"error": str(e)})
