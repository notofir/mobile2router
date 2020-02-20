import os
from urllib.request import urlopen


def is_internet_on():
    try:
        urlopen("https://www.google.com/", timeout=10)
        return True

    except:
        return False


def reset_internet():
    print("Resetting internet")
    os.system("ifdown br0; ifup br0")


if not is_internet_on():
    reset_internet()
