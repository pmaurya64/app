import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import joblib

# Function to train the model and save it to a .pkl file
def train_model():
    # Load dataset (make sure you replace this with your actual dataset path)
    data = pd.read_csv('model/dataset.csv')  # Adjust path if needed

    # Define your features (independent variables) and target (dependent variable)
    X = data[['area', 'rooms']]  # Replace with your actual feature columns
    y = data['price']  # Replace with your target column name (e.g., price)

    # Split data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Scale the features (important for linear regression)
    scaler = StandardScaler()
    X_train = scaler.fit_transform(X_train)
    X_test = scaler.transform(X_test)

    # Train the linear regression model
    model = LinearRegression()
    model.fit(X_train, y_train)

    # Save the model and scaler to files
    joblib.dump(model, 'model/house_price_model.pkl')
    joblib.dump(scaler, 'model/scaler.pkl')

    # Optionally, you can also return the model and scaler to check
    return model, scaler

# Function to predict the price using the trained model
def predict_price(features):
    # Load the trained model and scaler from the .pkl files
    model = joblib.load('model/house_price_model.pkl')
    scaler = joblib.load('model/scaler.pkl')
    
    # Scale the input features using the loaded scaler
    features_scaled = scaler.transform([features])

    # Predict the price using the trained model
    predicted_price = model.predict(features_scaled)

    # Return the predicted price (first element as it's a single prediction)
    return predicted_price[0]

if __name__ == "__main__":
    # Optionally, you can run the model training when this script is executed directly
    train_model()  # This will train and save the model when run directly

