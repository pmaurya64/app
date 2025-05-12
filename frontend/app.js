document.getElementById("predict-form").addEventListener("submit", function(e) {
    e.preventDefault();

    let area = document.getElementById("area").value;
    let rooms = document.getElementById("rooms").value;

    // Send a POST request to the Flask API
    fetch('http://127.0.0.1:5000/predict', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            features: [area, rooms]
        })
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById("prediction-result").innerHTML = 
            `Predicted House Price: $${data.predicted_price.toFixed(2)}`;
    })
    .catch(error => console.error('Error:', error));
});

