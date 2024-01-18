from flask import Flask, render_template, request, jsonify
import speech_recognition as sr
from translations import translations
from googletrans import Translator
from langdetect import detect

app = Flask(__name__)


@app.route('/')
def home():
    return render_template('index.html')


def english_to_shona(text):
    # data = request.get_json()
    text = text
    words = text.split()
    translated_words = []
    for word in words:
        if word.lower() in translations:
            translated_words.append(translations[word.lower()])
        else:
            translated_words.append(word)
    translated_text = ' '.join(translated_words)
    print(translated_text)
    return jsonify({'translation': translated_text})


@app.route('/speech-to-text', methods=['POST'])
def speech_to_text():
    r = sr.Recognizer()
    with sr.Microphone() as source:
        audio = r.listen(source)
    try:
        text = r.recognize_google(audio)
    except sr.UnknownValueError:
        text = "Could not understand audio"
    except sr.RequestError as e:
        text = "Could not request results from Google Speech Recognition service; {0}".format(e)
    # english_to_shona(text)
    words = text.split()

    translator = Translator()
    result = translator.translate(text, src='en', dest='sn')

    print(result.src)
    print(result.dest)
    print(result.text)

    translated_words = []
    for word in words:
        if word.lower() in translations:
            translated_words.append(translations[word.lower()])
        else:
            translated_words.append(word)
    translated_text = ' '.join(translated_words)
    print(translated_text)
    heading = "Shona Translation"
    heading2 = "Transcript"
    return render_template('index.html', text=text, shona=result.text, heading=heading)


if __name__ == '__main__':
    app.run(debug=True)
