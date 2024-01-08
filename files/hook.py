#!/usr/bin/env python3
"""
Flask app to trigger the script to pull the latest changes from MkDocs
"""
import subprocess
from flask import Flask

hook = Flask(__name__)


@hook.route('/hook', methods=['GET', 'POST'])
def trigger_script():
    """Trigger the script to pull the latest changes from MkDocs"""
    try:
        subprocess.run(['/usr/local/bin/pull-updates.sh'], check=True)
        return 'MkDocs updated!', 200
    except subprocess.CalledProcessError as e:
        return f'Error updating MkDocs: {e}', 500

if __name__ == '__main__':
    hook.run(debug=False)
