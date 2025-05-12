
from flask import Flask, request, jsonify
from model.linear_regression import predict_price
from flask_cors import CORS

app = Flask(__name__)

CORS(app)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()  # Get data sent from frontend
    features = data['features']  # e.g., number of rooms, area, etc.
    
    predicted_price = predict_price(features)
    return jsonify({'predicted_price': predicted_price})


@app.route('/')
def home():
    return 'Welcome to the House Price Prediction API!'


if __name__ == '__main__':
    app.run(debug=True)

