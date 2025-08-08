import firebase_admin
from firebase_admin import credentials, firestore
from datetime import datetime
import random
import time

# ✅ 1. Firebase Admin SDK Initialization
cred = credentials.Certificate("backend/credentials/pricehawk-deals-firebase-adminsdk-fbsvc-2b043ba4cd.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

# ✅ 2. Dummy product price fetcher (use real scraping later)
def get_product_price(url):
    dummy_price = random.randint(500, 20000)  # Replace with real scraping
    return dummy_price

# ✅ 3. Firestore updater
def update_price(user_id, product_name, url, is_premium=False, premium_duration=0):
    price = get_product_price(url)
    timestamp = datetime.utcnow()

    data = {
        "userId": user_id,
        "product": product_name,
        "price": price,
        "timestamp": timestamp,
        "premium": is_premium,
        "premiumDuration": premium_duration,
    }

    db.collection("tracked_products").add(data)
    print(f"[✅] {product_name} updated with ₹{price} at {timestamp}")

# ✅ 4. Auto Loop Tracker
def start_tracking_loop():
    user_id = "test_user_001"
    product_name = "boAt Airdopes 141"
    url = "https://www.amazon.in/dp/B093B5Q5BZ"

    while True:
        update_price(user_id, product_name, url, is_premium=False, premium_duration=0)
        print("🔁 Waiting 3 hours before next check...\n")
        time.sleep(10800)  # 3 hours

# ✅ 5. Entry Point
if __name__ == "__main__":
    print("📡 Price tracking started...")
    start_tracking_loop()
