#!/usr/bin/env python3
"""Generate the deterministic seed data the text-processing lab operates on.

Produces:
  sample.log        ~5000 Apache Combined Log Format lines (field 9 = status)
  data/metrics.csv  small CSV for awk -F',' practice
  data/access.csv   small CSV
  data/app.log      a second .log file so `find` returns >1 match
"""
import os
import random

random.seed(42)  # deterministic so the lesson's "expected output" numbers are stable

os.makedirs("data", exist_ok=True)

PATHS = ["/", "/api/users", "/api/orders", "/login", "/static/app.js", "/health"]
METHODS = ["GET", "POST", "PUT", "DELETE"]
# Weighted status distribution: mostly 200, some 301/404, a tail of 500.
STATUS_POOL = ["200"] * 70 + ["301"] * 12 + ["404"] * 12 + ["500"] * 6

with open("sample.log", "w") as f:
    for i in range(5000):
        ip = f"10.0.{random.randint(0, 4)}.{random.randint(1, 254)}"
        method = random.choice(METHODS)
        path = random.choice(PATHS)
        status = random.choice(STATUS_POOL)
        size = random.randint(120, 4096)
        ts = f"01/Jun/2026:{10 + i % 12:02d}:{i % 60:02d}:{(i * 7) % 60:02d} +0000"
        f.write(f'{ip} - - [{ts}] "{method} {path} HTTP/1.0" {status} {size}\n')

with open("data/metrics.csv", "w") as f:
    f.write("host,metric,value\n")
    for i in range(49):
        f.write(f"node{i % 5},cpu,{random.randint(1, 99)}\n")

with open("data/access.csv", "w") as f:
    f.write("user,action\n")
    for i in range(99):
        f.write(f"user{i},{random.choice(['view', 'edit', 'delete'])}\n")

with open("data/app.log", "w") as f:
    for i in range(200):
        lvl = random.choice(["INFO", "WARN", "ERROR"])
        f.write(f"2026-06-01 10:00:{i % 60:02d} {lvl} request {i} handled\n")

print("seed: wrote sample.log (5000 lines) + data/{metrics.csv,access.csv,app.log}")
