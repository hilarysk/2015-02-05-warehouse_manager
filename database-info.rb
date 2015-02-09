# 1. Actually populate tables
# 2. get insert and save working
# 3. work on other methods remaining

        
        
SELECT table1.column_name, table1.column_name2, table1.column_name3, table2.column_name
FROM table1
JOIN table2
ON table1.column_name = table2.column_name;



SELECT products.name, products.quantity, locations.name
FROM products
JOIN locations
ON products.locations_id = locations.id;




c1 = Category.new({"name"=>"board games", "description"=>"The best of the best in tabletop entertainment"})
c2 = Category.new({"name"=>"90s-00s toys", "description"=>"Old things you may or may not remember."})

l1 = Location.new({"name"=>"Room 1", "description"=>"Try the green bookcase"})
l2 = Location.new({"name"=>"Room 2", "description"=>"Under the desk? Or maybe in the closet."})
l3 = Location.new({"name"=>"Room 3", "description"=>"Scattered against the walls"})
l4 = Location.new({"name"=>"Room 4", "description"=>"Stacked on the shelves in labled boxes"})

p1 = Product.new({"serial_num"=>93728, "description"=>"You know what the world needs? More games centered on Elizabethan-era gem merchants.", "quantity"=>47, "name"=>"Splendor", "cost"=>2799, "location_id"=>1, "category_id"=>1})
p2 = Product.new({"serial_num"=>37749, "description"=>"A stressful, complicated Euro-style game where you spend the entire time agnozing over which of your meeples are going to starve to death.", "quantity"=>179, "name"=>"Agricola", "cost"=>4500, "location_id"=>2, "category_id"=>1})
p3 = Product.new({"serial_num"=>78437, "description"=>"Um, it is a board game based on D&D. And you can go on a quest to DOMESTICATE OWLBEARS. Enough said.", "quantity"=>32, "name"=>"Lords of Waterdeep", "cost"=>3499, "location_id"=>2, "category_id"=>1})
p4 = Product.new({"serial_num"=>61632, "description"=>"A simultaneous-play game where you try to build one of the seven wonders of the world while fighting off your neighbors hordes and stealing their resources.", "quantity"=>92, "name"=>"7 Wonders", "cost"=>3299, "location_id"=>2, "category_id"=>1})
p5 = Product.new({"serial_num"=>60984, "description"=>"You remember 80s tech movies like -Hackers-, -The Net- and -Johnny Mneumonic-? This is like that, plus deckbuilding. Two players.", "quantity"=>56, "name"=>"Netrunner", "cost"=>2499, "location_id"=>1, "category_id"=>1})
p6 = Product.new({"serial_num"=>18779, "description"=>"This is supposedly a game for kids, but especially if you play when you are really stoned, it is still pretty fun.", "quantity"=>11, "name"=>"The aMAZEing Labyrinth", "cost"=>1199, "location_id"=>1, "category_id"=>1})
p7 = Product.new({"serial_num"=>72632, "description"=>"It is a mix of luck and strategy, but if both go your way, you can obliterate everyone in one fell swoop. Plus your avatars are bad-ass monsters.", "quantity"=>142, "name"=>"King of Tokyo", "cost"=>2799, "location_id"=>1, "category_id"=>1})

p8 = Product.new({"serial_num"=>875, "description"=>"Yeah, yeah, we know, you are so over this game. But it is the hexagon that launched a thousand knock-offs, so let us give credit where credit is due.", "quantity"=>76, "name"=>"Settlers of Catan", "cost"=>1849, "location_id"=>1, "category_id"=>1})
p9 = Product.new({"serial_num"=>22815, "description"=>"Useless little coin-like things that you collect.", "quantity"=>10000, "name"=>"Pogs", "cost"=>500, "location_id"=>3, "category_id"=>2})
p10 = Product.new({"serial_num"=>20681, "description"=>"Robo-dogs -- Less mess than an actual dog!", "quantity"=>59, "name"=>"Poochie", "cost"=>4000, "location_id"=>4, "category_id"=>2})
p11 = Product.new({"serial_num"=>68247, "description"=>"Great for listening to only part of the song.", "quantity"=>42, "name"=>"Hit Clips", "cost"=>2000, "location_id"=>4, "category_id"=>2})
p12 = Product.new({"serial_num"=>27042, "description"=>"Little pocket pets, becareful - you can kill them.", "quantity"=>12, "name"=>"Tamagatchi", "cost"=>1500, "location_id"=>4, "category_id"=>2})
p13 = Product.new({"serial_num"=>47003, "description"=>"Do NOT swallow these.", "quantity"=>54, "name"=>"Polly Pockets", "cost"=>1000, "location_id"=>3, "category_id"=>2})
p14 = Product.new({"serial_num"=>21103, "description"=>"Great deterent for unwanted homework.", "quantity"=>125, "name"=>"Gameboy Color", "cost"=>5000, "location_id"=>4, "category_id"=>2})
p15 = Product.new({"serial_num"=>85076, "description"=>"Gotta catch em all!", "quantity"=>8573, "name"=>"Pokemon Cards", "cost"=>500, "location_id"=>3, "category_id"=>2})
p16 = Product.new({"serial_num"=>96422, "description"=>"Do NOT eat it.", "quantity"=>2817, "name"=>"Gak", "cost"=>500, "location_id"=>3, "category_id"=>2})

                                                       
# ----------------------------------------------------------------------------------------------               
# 
# 2.DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, name TEXT,
# quantity INTEGER CHECK(quantity >= 0), description TEXT DEFAULT(null),
# serial_num INTEGER CHECK(serial_num >= 0), category_id INTEGER, location_id INTEGER,
# FOREIGN KEY(category_id) REFERENCES categories(id), FOREIGN KEY(location_id) REFERENCES locations(id))")

# Extensions:

# Be able to look at my products, ordered from most numerous to least numerous. This could also be further broken down by category or by location, if the user so desired.

# ---> Add a "Shopping Cart" feature where you add products to a shopping cart and where it adds up the total cost. Upon purchasing the cart, update each of the relevant product quantities accordingly. (new table?)

# Depending on the category, products might have different relevant information (for example: a book might have an author, but a death ray would not). Given the categories you've created so far, create templates for this relevant information. Use the templates to track additional information. Don't worry about letting the user create templates from scratch; you can hard-code those.

# Add in the ability to search for products whose description contains the search word (in this case, your search query should be a single word long).


# Come up with your own extension and make it happen.