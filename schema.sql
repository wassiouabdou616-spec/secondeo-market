CREATE TABLE IF NOT EXISTS users(
 id BIGSERIAL PRIMARY KEY, name TEXT NOT NULL, email TEXT UNIQUE NOT NULL,
 password_hash TEXT NOT NULL, role TEXT NOT NULL DEFAULT 'buyer',
 stripe_account_id TEXT, created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS products(
 id BIGSERIAL PRIMARY KEY, seller_id BIGINT REFERENCES users(id),
 title TEXT NOT NULL, description TEXT, price_cents INTEGER NOT NULL CHECK(price_cents>=0),
 category TEXT, condition TEXT, city TEXT, status TEXT DEFAULT 'pending',
 created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS product_images(
 id BIGSERIAL PRIMARY KEY, product_id BIGINT REFERENCES products(id) ON DELETE CASCADE,
 url TEXT NOT NULL, is_cover BOOLEAN DEFAULT false
);
CREATE TABLE IF NOT EXISTS carts(
 id BIGSERIAL PRIMARY KEY, buyer_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
 product_id BIGINT REFERENCES products(id) ON DELETE CASCADE, quantity INTEGER NOT NULL DEFAULT 1,
 UNIQUE(buyer_id,product_id)
);
CREATE TABLE IF NOT EXISTS orders(
 id BIGSERIAL PRIMARY KEY, buyer_id BIGINT REFERENCES users(id),
 subtotal_cents INTEGER NOT NULL, shipping_cents INTEGER NOT NULL DEFAULT 499,
 total_cents INTEGER NOT NULL, payment_status TEXT DEFAULT 'pending',
 shipping_status TEXT DEFAULT 'pending', status TEXT DEFAULT 'payment_pending',
 stripe_payment_intent TEXT, created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS order_items(
 id BIGSERIAL PRIMARY KEY, order_id BIGINT REFERENCES orders(id) ON DELETE CASCADE,
 product_id BIGINT REFERENCES products(id), seller_id BIGINT REFERENCES users(id),
 title TEXT NOT NULL, unit_price_cents INTEGER NOT NULL, quantity INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS reviews(
 id BIGSERIAL PRIMARY KEY, buyer_id BIGINT REFERENCES users(id),
 seller_id BIGINT REFERENCES users(id), product_id BIGINT REFERENCES products(id),
 rating INTEGER CHECK(rating BETWEEN 1 AND 5), comment TEXT, created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS reports(
 id BIGSERIAL PRIMARY KEY, reporter_id BIGINT REFERENCES users(id),
 product_id BIGINT REFERENCES products(id), reason TEXT, status TEXT DEFAULT 'open',
 created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS seller_profiles(
 id BIGSERIAL PRIMARY KEY, user_id BIGINT UNIQUE REFERENCES users(id) ON DELETE CASCADE,
 shop_name TEXT NOT NULL, bio TEXT DEFAULT '', avatar_url TEXT DEFAULT '', city TEXT DEFAULT '',
 created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS favorites(
 buyer_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
 product_id BIGINT REFERENCES products(id) ON DELETE CASCADE,
 created_at TIMESTAMPTZ DEFAULT now(),
 PRIMARY KEY(buyer_id,product_id)
);
CREATE TABLE IF NOT EXISTS conversations(
 id BIGSERIAL PRIMARY KEY, buyer_id BIGINT REFERENCES users(id),
 seller_id BIGINT REFERENCES users(id), product_id BIGINT REFERENCES products(id),
 created_at TIMESTAMPTZ DEFAULT now(), UNIQUE(buyer_id,seller_id,product_id)
);
CREATE TABLE IF NOT EXISTS messages(
 id BIGSERIAL PRIMARY KEY, conversation_id BIGINT REFERENCES conversations(id) ON DELETE CASCADE,
 sender_id BIGINT REFERENCES users(id), body TEXT NOT NULL, read_at TIMESTAMPTZ,
 created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS notifications(
 id BIGSERIAL PRIMARY KEY, user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
 type TEXT NOT NULL, title TEXT NOT NULL, body TEXT DEFAULT '', read_at TIMESTAMPTZ,
 created_at TIMESTAMPTZ DEFAULT now()
);
