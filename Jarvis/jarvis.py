from flask import Flask, render_template, request, jsonify
import datetime
import wikipedia
import pyjokes

app = Flask(__name__)

def get_time():
    return datetime.datetime.now().strftime("%I:%M:%S %p")

def get_date():
    now = datetime.datetime.now()
    return f"{now.day}-{now.month}-{now.year}"

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/command', methods=['POST'])
def command():
    data = request.json
    query = data.get('query', '').lower()

    if "time" in query:
        return jsonify({"response": f"Current time is {get_time()}"})

    elif "date" in query:
        return jsonify({"response": f"Today's date is {get_date()}"})

    elif "wikipedia" in query:
        try:
            q = query.replace("wikipedia", "").strip()
            result = wikipedia.summary(q, sentences=2)
            return jsonify({"response": result})
        except:
            return jsonify({"response": "No result found."})

    elif "joke" in query:
        return jsonify({"response": pyjokes.get_joke()})

    else:
        return jsonify({"response": "Sorry, I didn't understand that."})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
