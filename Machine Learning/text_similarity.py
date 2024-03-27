import PyPDF2
from flask import Blueprint, request, jsonify
import spacy
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import requests
import io

my_text_similarity = Blueprint('my_text_similarity', __name__)

nlp = spacy.load("en_core_web_md")


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


def json_to_dictionary(data):
    my_dict = {}  # create an empty dictionary
    for key, value in data.items():
        my_dict[key] = value

    return my_dict


@my_text_similarity.route("/text-similarity", methods=["POST"])
def calculate_Similarity():
    if request.method == "POST":
        json = request.get_json()

        if json is None or json == "":
            return jsonify({"error": "No input provided"})

        try:
            # Change JSON to dictionary
            applicants_dict = json_to_dictionary(json)

            job_description_text = applicants_dict['job_description']

            job_doc = nlp(job_description_text)
            job_tokens = [token.lemma_ for token in job_doc if not token.is_stop and not token.is_punct]

            data = {}
            for key, value in applicants_dict['cvs'].items():
                # Extract text from the CV download url
                cv_text = extract_text_from_url(value)

                # Tokenize and lemmatize CV
                cv_doc = nlp(cv_text)
                cv_tokens = [token.lemma_ for token in cv_doc if not token.is_stop]
                common = set(cv_tokens) & set(job_tokens)

                job_text = " ".join(job_tokens)
                cv_text = " ".join(common)
                tfidf = TfidfVectorizer()
                tfidf_matrix = tfidf.fit_transform([job_text, cv_text])
                cosine_sim = cosine_similarity(tfidf_matrix[0], tfidf_matrix[1]) * 100

                text_sim = cosine_sim[0][0]

                data[key] = round(text_sim, 3)

            return jsonify(data)

        except Exception as e:
            return jsonify({"error": str(e)})
