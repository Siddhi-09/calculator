from flask import Flask, request, jsonify

app = Flask(__name__)

def add(x, y):
    return x + y

def subtract(x, y):
    return x - y

def multiply(x, y):
    return x * y

def divide(x, y):
    if y == 0:
        return "Error! Division by zero."
    return x / y

@app.route('/calculate', methods=['GET'])
def calculate():
    # Get query parameters: operation, num1, num2
    operation = request.args.get('operation')
    try:
        num1 = float(request.args.get('num1'))
        num2 = float(request.args.get('num2'))
    except (TypeError, ValueError):
        return jsonify({'error': 'Invalid or missing numbers'}), 400

    if operation == 'add':
        result = add(num1, num2)
    elif operation == 'subtract':
        result = subtract(num1, num2)
    elif operation == 'multiply':
        result = multiply(num1, num2)
    elif operation == 'divide':
        result = divide(num1, num2)
    else:
        return jsonify({'error': 'Invalid operation'}), 400

    return jsonify({'operation': operation, 'num1': num1, 'num2': num2, 'result': result})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
