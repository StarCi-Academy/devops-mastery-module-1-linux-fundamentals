import time

i = 0
while True:
    print(f"[worker] tick {i}", flush=True)
    time.sleep(2)
    i += 1
