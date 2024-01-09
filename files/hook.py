#!/usr/bin/env python3
"""
Flask app to trigger the script to pull the latest changes from MkDocs
"""
import subprocess
from flask import Flask
from flask import jsonify

HOOK = Flask(__name__)


@HOOK.route("/hookz/<branch>", methods=["GET", "POST"])
def trigger_script(branch):
    """Trigger the script to pull the latest changes from MkDocs"""
    try:
        subprocess.run(["/usr/local/bin/pull-updates.sh", branch], check=True)
        return "MkDocs updated!", 200
    except subprocess.CalledProcessError as e:
        return f"Error updating MkDocs: {e}", 500


@HOOK.route("/healthz")
def health_check():
    """health-check"""
    return jsonify(status="OK")


if __name__ == "__main__":
    HOOK.run(debug=False)
