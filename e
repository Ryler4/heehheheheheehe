// Create a button to launch the executor
const runButton = document.createElement('button');
runButton.textContent = 'Open Movable Executor';
document.body.appendChild(runButton);

// Add styles for the main body
document.body.style.fontFamily = 'Arial, sans-serif';
document.body.style.backgroundColor = '#e9ecef';
document.body.style.margin = '0';
document.body.style.padding = '20px';
document.body.style.display = 'flex';
document.body.style.justifyContent = 'center';
document.body.style.alignItems = 'center';
document.body.style.height = '100vh';

// Add event listener to the button
runButton.onclick = function() {
    // Create the executor box
    const box = document.createElement('div');
    const header = document.createElement('div');
    const textarea = document.createElement('textarea');
    const runCodeButton = document.createElement('button');
    const clearButton = document.createElement('button');
    const outputToggle = document.createElement('button');
    const outputArea = document.createElement('pre');
    const closeButton = document.createElement('button');
    const ctrlMessage = document.createElement('div');

    // Style the executor box
    box.style.width = '400px';
    box.style.padding = '15px';
    box.style.border = '2px solid #007BFF';
    box.style.borderRadius = '5px';
    box.style.backgroundColor = '#ffffff';
    box.style.position = 'absolute';
    box.style.cursor = 'move';
    box.style.top = '100px';
    box.style.left = '100px';
    box.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.2)';
    box.style.zIndex = '1000'; // Ensure it stays on top

    // Style the header
    header.textContent = 'Movable JavaScript Executor';
    header.style.backgroundColor = '#007BFF';
    header.style.color = '#ffffff';
    header.style.padding = '10px';
    header.style.textAlign = 'center';
    header.style.borderRadius = '5px 5px 0 0';

    // Style the textarea
    textarea.placeholder = 'Write JavaScript code...';
    textarea.style.width = '100%';
    textarea.style.height = '100px';
    textarea.style.border = '1px solid #ccc';
    textarea.style.borderRadius = '4px';
    textarea.style.padding = '5px';
    textarea.style.fontSize = '14px';
    textarea.style.resize = 'none'; // Prevent resizing

    // Set up buttons
    runCodeButton.textContent = 'Run Code';
    clearButton.textContent = 'Clear';
    outputToggle.textContent = 'Show Output';
    closeButton.textContent = 'X';

    // Style the buttons
    const buttonStyle = {
        marginTop: '10px',
        padding: '8px 12px',
        borderRadius: '4px',
        border: 'none',
        cursor: 'pointer',
        fontSize: '14px',
        color: '#ffffff'
    };

    runCodeButton.style.backgroundColor = '#28a745';
    Object.assign(runCodeButton.style, buttonStyle);

    clearButton.style.backgroundColor = '#ffc107';
    Object.assign(clearButton.style, buttonStyle);

    outputToggle.style.backgroundColor = '#007BFF';
    Object.assign(outputToggle.style, buttonStyle);

    closeButton.style.color = 'red';
    closeButton.style.cursor = 'pointer';

    // Initially hide the output area
    outputArea.style.background = '#eaeaea';
    outputArea.style.padding = '10px';
    outputArea.style.border = '1px solid #ccc';
    outputArea.style.marginTop = '10px';
    outputArea.style.display = 'none'; // Initially hidden
    outputArea.style.overflow = 'auto'; // Enable scrolling if output is large

    // Style the message
    ctrlMessage.textContent = 'Press Ctrl + E to hide/show this box';
    ctrlMessage.style.fontSize = '12px';
    ctrlMessage.style.color = '#666';
    ctrlMessage.style.marginTop = '10px';
    ctrlMessage.style.textAlign = 'center';

    // Append elements to the box
    box.appendChild(header);
    box.appendChild(closeButton);
    box.appendChild(textarea);
    box.appendChild(runCodeButton);
    box.appendChild(clearButton);
    box.appendChild(outputToggle);
    box.appendChild(outputArea);
    box.appendChild(ctrlMessage);
    document.body.appendChild(box);

    // Make the box draggable
    let offsetX, offsetY;

    box.onmousedown = function(e) {
        e.preventDefault();
        offsetX = e.clientX - box.getBoundingClientRect().left;
        offsetY = e.clientY - box.getBoundingClientRect().top;
        document.onmousemove = moveBox;
        document.onmouseup = stopDragging;
    };

    function moveBox(e) {
        box.style.left = (e.clientX - offsetX) + 'px';
        box.style.top = (e.clientY - offsetY) + 'px';
    }

    function stopDragging() {
        document.onmouseup = null;
        document.onmousemove = null;
    }

    // Execute code on button click
    runCodeButton.onclick = function() {
        try {
            const result = eval(textarea.value);
            outputArea.textContent = result !== undefined ? result : 'Code executed successfully.';
            outputArea.style.color = 'black'; // Reset color for success
            outputArea.style.display = 'block'; // Show output area
        } catch (error) {
            outputArea.textContent = 'Error: ' + error.message;
            outputArea.style.color = 'red'; // Change color for errors
            outputArea.style.display = 'block'; // Show output area
        }
    };

    // Clear the textarea and output area
    clearButton.onclick = function() {
        textarea.value = '';
        outputArea.textContent = '';
        outputArea.style.display = 'none'; // Hide output area
    };

    // Toggle output visibility
    outputToggle.onclick = function() {
        outputArea.style.display = outputArea.style.display === 'block' ? 'none' : 'block';
        outputToggle.textContent = outputArea.style.display === 'block' ? 'Hide Output' : 'Show Output';
    };

    // Close the box
    closeButton.onclick = function() {
        box.remove();
    };

    // Minimize/Maximize with Ctrl + E
    document.addEventListener('keydown', function(event) {
        if (event.ctrlKey && event.key === 'e') {
            event.preventDefault();
            const isHidden = box.style.display === 'none';
            box.style.display = isHidden ? 'block' : 'none'; // Toggle visibility
        }
    });

    // Prevent focus loss when clicking inside textarea
    textarea.onmousedown = function(e) {
        e.stopPropagation();
    };

    // Make sure the box is interactive
    box.onclick = function(e) {
        e.stopPropagation();
    };

    // Remove the button after running the executor code
    runButton.remove();
};

// Append the button to the document
document.body.appendChild(runButton);
