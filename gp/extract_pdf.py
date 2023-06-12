from PyPDF2 import PdfReader
from pathlib import Path
import nltk
import os

nltk.download('stopwords')


# Extract Job Description from pdf and convert it into text file
def extract_all(pdf_path, text_path):
    folder_path = pdf_path

    # Get a list of all the files in the folder
    files = os.listdir(folder_path)

    # Filter the list to include only PDF files
    pdf_files = [file for file in files if file.endswith('.pdf')]

    # Print the names of the PDF files
    for file in pdf_files:
        pdf = PdfReader(pdf_path + file)
        with Path(text_path + file[:-4] + '.txt').open(mode='w', encoding='utf-8') as x_file:
            text = ''
            for page in pdf.pages:
                text += page.extract_text()
                x_file.write(text)
