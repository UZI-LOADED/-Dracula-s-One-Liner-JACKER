🩸 Step-by-Step Manual Setup
⚰️ 1. Folder Structure
Create this structure:

bash
Copy
Edit
Dracula_CurlReconToolkit/
├── data/
├── scripts/
│   └── curl_recon.sh
├── dashboard/
│   └── app.py
└── README.txt
⚙️ 2. curl_recon.sh – Dracula's Recon Script
📜 Save this in scripts/curl_recon.sh and make it executable:

bash
Copy
Edit
#!/bin/bash
# Dracula's Curl Recon Script

TARGET=$1
OUTDIR="../data"
mkdir -p $OUTDIR

echo "[🧛] Scanning $TARGET..."
curl -s -D $OUTDIR/headers.txt -o $OUTDIR/body.html $TARGET

echo "[🕵️] Extracting server headers..."
grep -i 'Server:' $OUTDIR/headers.txt

echo "[🔍] Searching for secrets in body..."
grep -iE "api[_-]?key|secret|token|password" $OUTDIR/body.html > $OUTDIR/findings.txt

echo "[📁] Recon complete. View ../data for output."
bash
Copy
Edit
chmod +x scripts/curl_recon.sh
💻 3. app.py – Flask Dashboard
📜 Save this in dashboard/app.py:

python
Copy
Edit
from flask import Flask, render_template_string
app = Flask(__name__)

@app.route('/')
def index():
    try:
        with open('../data/findings.txt') as f:
            findings = f.read().splitlines()
    except:
        findings = ['No findings yet. Run recon first.']
    return render_template_string("""
    <html>
    <head><title>🧛 Dracula Recon Dashboard</title></head>
    <body style='background:#111; color:#eee; font-family:monospace'>
        <h1>🩸 Dracula Recon Dashboard</h1>
        <h2>Findings:</h2>
        <ul>
        {% for item in findings %}
            <li>{{ item }}</li>
        {% endfor %}
        </ul>
    </body>
    </html>
    """, findings=findings)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
📘 4. README.txt
Save this at the root:

shell
Copy
Edit
🧛 Dracula Curl Recon Toolkit

Instructions:

1. Run Recon:
$ ./scripts/curl_recon.sh https://target-site.com

2. Start Dashboard:
$ cd dashboard
$ python3 app.py

Then open your browser at:
http://localhost:5000

🩸 All harvested info will appear in a Dracula-themed dashboard.
🧪 5. Run the Toolkit
bash
Copy
Edit
./scripts/curl_recon.sh https://example.com
cd dashboard
python3 app.py
Then visit: http://localhost:5000 to view the dark web harvest.
