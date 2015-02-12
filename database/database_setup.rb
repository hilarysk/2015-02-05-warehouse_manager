DATABASE = SQLite3::Database.new("warehouse_manager.db")

DATABASE.results_as_hash = true

DATABASE.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, name TEXT, description TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, name TEXT, description TEXT)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, name TEXT,
                                                     quantity INTEGER, cost INTEGER, description TEXT,
                                                     serial_num INTEGER UNIQUE, category_id INTEGER, location_id INTEGER, FOREIGN KEY(category_id) REFERENCES categories(id),
                                                     FOREIGN KEY(location_id) REFERENCES locations(id))")
