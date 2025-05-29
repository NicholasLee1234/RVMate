from flask import Flask, render_template, request
from matplotlib.figure import Figure
import io
import base64
import numpy as np
from datetime import datetime, timedelta
from sklearn.linear_model import LinearRegression

app = Flask(__name__)

# Global variables
amount_recycled = 0
bottle_types_final = {}  # Dictionary to store bottle types and their counts
recycling_dates = []  # List to store the dates of recycling
bottle_amount = []
date_of_entries = []

@app.route('/home', methods=['GET', 'POST'])
def home_page():
    global amount_recycled, bottle_types_final, recycling_dates, bottle_amount, date_of_entries

    carbon_emission_graph_img = None
    bottle_distribution_graph_img = None
    lin_reg_graph_img = None
    one_year_prediction_text = ""

    if request.method == 'POST':
        try:
            # Handle bottles recycled count
            recycled_input = int(request.form.get('recycled', 0))
            amount_recycled += recycled_input
            bottle_amount.append(recycled_input)

            # Handle bottle type
            bottle_type = request.form.get('bottle_type', '').strip()
            if bottle_type:
                if bottle_type in bottle_types_final:
                    bottle_types_final[bottle_type] += recycled_input
                else:
                    bottle_types_final[bottle_type] = recycled_input

            # Handle recycling date
            date_input = request.form.get('recycle_date', '')
            if date_input:
                date_of_entry = datetime.strptime(date_input, "%Y-%m-%d")
                recycling_dates.append(date_input)
                date_of_entries.append(date_of_entry)
        except (ValueError, TypeError):
            pass  # Ignore invalid input

    # Generate carbon emission graph
    if bottle_amount and date_of_entries:
        carbon_emission_graph_img = generate_carbon_emission_graph()

    # Generate bottle distribution graph
    if bottle_types_final:
        bottle_distribution_graph_img = generate_bottle_distribution_graph()

    # Generate linear regression chart and prediction text
    if bottle_amount and date_of_entries:
        lin_reg_graph_img, one_year_prediction_text = generate_linear_regression_chart()

    return render_template(
        'home.html',
        amount_recycled=amount_recycled,
        bottle_types_final=bottle_types_final,
        recycling_dates=recycling_dates,
        carbon_emission_graph_img=carbon_emission_graph_img,
        bottle_distribution_graph_img=bottle_distribution_graph_img,
        lin_reg_graph_img=lin_reg_graph_img,
        one_year_prediction_text=one_year_prediction_text
    )

def generate_carbon_emission_graph():
    dates_as_numbers = [(date - date_of_entries[0]).days for date in date_of_entries]
    carbon_emissions = np.array(bottle_amount) * 94
    lower_bound = carbon_emissions * 0.9
    upper_bound = carbon_emissions * 1.1

    fig = Figure(figsize=(10, 6))
    ax = fig.add_subplot(1, 1, 1)
    ax.scatter(dates_as_numbers, carbon_emissions, color='blue', label='Actual Data')
    for x, y, y_low, y_high in zip(dates_as_numbers, carbon_emissions, lower_bound, upper_bound):
        ax.vlines(x, y_low, y_high, color='gray', linestyle='dashed', linewidth=1)
    ax.set_xlabel('Time Since First Entry (days)')
    ax.set_ylabel('Carbon Dioxide Emitted (g)')
    ax.set_title('Carbon Emissions with 10% Buffer')
    ax.legend()

    buf = io.BytesIO()
    fig.savefig(buf, format='png')
    buf.seek(0)
    encoded_image = base64.b64encode(buf.getvalue()).decode('utf-8')
    buf.close()
    return f"data:image/png;base64,{encoded_image}"

def generate_bottle_distribution_graph():
    bottle_types = list(bottle_types_final.keys())
    counts = list(bottle_types_final.values())

    fig = Figure(figsize=(8, 6))
    ax = fig.add_subplot(1, 1, 1)
    ax.bar(bottle_types, counts, color='green')
    ax.set_xlabel('Bottle Types')
    ax.set_ylabel('Count')
    ax.set_title('Bottle Distribution')

    buf = io.BytesIO()
    fig.savefig(buf, format='png')
    buf.seek(0)
    encoded_image = base64.b64encode(buf.getvalue()).decode('utf-8')
    buf.close()
    return f"data:image/png;base64,{encoded_image}"

def generate_linear_regression_chart():
    # Prepare data for linear regression
    dates_as_numbers = np.array([(date - date_of_entries[0]).days for date in date_of_entries]).reshape(-1, 1)
    bottle_counts = np.array(bottle_amount).reshape(-1, 1)

    # Perform linear regression
    model = LinearRegression()
    model.fit(dates_as_numbers, bottle_counts)

    # Predict for the next year (365 days from the last entry)
    last_entry_date = (date_of_entries[-1] - date_of_entries[0]).days
    future_days = np.array(range(last_entry_date + 1, last_entry_date + 366)).reshape(-1, 1)
    future_predictions = model.predict(future_days)

    # Predict total bottles in 1 year
    one_year_prediction = int(model.predict([[last_entry_date + 365]])[0][0])
    prediction_text = f"In 1 year, approximately {one_year_prediction} bottles will be recycled."

    # Create the plot
    fig = Figure(figsize=(10, 6))
    ax = fig.add_subplot(1, 1, 1)
    ax.scatter(dates_as_numbers, bottle_counts, color='blue', label='Actual Data')
    ax.plot(dates_as_numbers, model.predict(dates_as_numbers), color='red', label='Regression Line')
    ax.plot(future_days, future_predictions, color='orange', linestyle='dashed', label='Prediction')
    ax.set_xlabel('Days Since First Entry')
    ax.set_ylabel('Number of Bottles Recycled')
    ax.set_title('Time Series and Prediction of Bottles Recycled')
    ax.legend()

    # Convert plot to base64
    buf = io.BytesIO()
    fig.savefig(buf, format='png')
    buf.seek(0)
    encoded_image = base64.b64encode(buf.getvalue()).decode('utf-8')
    buf.close()
    return f"data:image/png;base64,{encoded_image}", prediction_text

if __name__ == '__main__':
    app.run(debug=True)
