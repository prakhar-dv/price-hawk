import requests
from bs4 import BeautifulSoup
import re

headers = {
    "User-Agent": "Mozilla/5.0",
    "Accept-Language": "en-IN,en;q=0.9"
}

# ✅ Amazon
def get_amazon_price(url):
    try:
        r = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(r.content, 'html.parser')
        price = soup.find("span", {"class": "a-price-whole"})
        if price:
            return int(price.text.replace(",", "").strip())
    except Exception as e:
        print(f"[Amazon] ❌ {e}")
    return None

# ✅ Flipkart
def get_flipkart_price(url):
    try:
        r = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(r.text, "html.parser")
        price = soup.find("div", {"class": "_30jeq3 _16Jk6d"})
        if price:
            return int(re.sub("[^0-9]", "", price.text))
    except Exception as e:
        print(f"[Flipkart] ❌ {e}")
    return None

# ✅ Meesho
def get_meesho_price(url):
    try:
        r = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(r.text, "html.parser")
        price = soup.find("h4", {"class": "pdp-discounted-price"})
        if price:
            return int(re.sub("[^0-9]", "", price.text))
    except Exception as e:
        print(f"[Meesho] ❌ {e}")
    return None

# ✅ Myntra
def get_myntra_price(url):
    try:
        r = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(r.text, "html.parser")
        price = soup.find("span", {"class": "pdp-price"})
        if price:
            return int(re.sub("[^0-9]", "", price.text))
    except Exception as e:
        print(f"[Myntra] ❌ {e}")
    return None

# ✅ Detect site & call correct function
def get_price(url):
    if "amazon" in url:
        return get_amazon_price(url)
    elif "flipkart" in url:
        return get_flipkart_price(url)
    elif "meesho" in url:
        return get_meesho_price(url)
    elif "myntra" in url:
        return get_myntra_price(url)
    else:
        print("❌ Unsupported site")
        return None

# 🔁 Test
if __name__ == "__main__":
    test_urls = [
        "https://www.amazon.in/dp/B093B5Q5BZ",
        "https://www.flipkart.com/p/itm0ae6f7a1a9f32",
        "https://www.meesho.com/p/16m8xi",
        "https://www.myntra.com/p/12581078"
    ]
    for url in test_urls:
        price = get_price(url)
        print(f"💰 Price from {url.split('.')[1].capitalize()}: ₹{price}")
