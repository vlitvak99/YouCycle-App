INSERT INTO Users (Username, Password, FirstName, LastName, Email, ZipCode) VALUES ('john.smith', 'pswrd', 'John', 'Smith', 'johnsmith123@example.com', 95112);
INSERT INTO Users (Username, Password, FirstName, LastName, Email, ZipCode) VALUES ('jdoe200', 'PaSsWoRd', 'Jane', 'Doe', 'j.doe@example.com', 95112);
INSERT INTO Users (Username, Password, FirstName, LastName, Email, ZipCode) VALUES ('brianj', 'pass', 'Brian', 'Johnson', 'brian.johnson@example.com', 10022);

#should fail, username not unique
INSERT INTO Users (Username, Password, FirstName, LastName, Email, ZipCode) VALUES ('jdoe200', 'PaSsWoRd', 'John', 'Doe', 'johnd200@example.com', 95112);
#should fail, email not unique
INSERT INTO Users (Username, Password, FirstName, LastName, Email, ZipCode) VALUES ('jdoe2ndAccount', 'PaSsWoRd', 'Jane', 'Doe', 'j.doe@example.com', 95112);

INSERT INTO Recycling (Username, ProductName, Category) VALUES ('john.smith', 'Paper Bag', 'M');
INSERT INTO Recycling (Username, ProductName, Category, RecycleNumber) VALUES ('john.smith', 'Plastic Bottle', 'C', 2);
INSERT INTO Recycling (Username, ProductName, Category, RecycleNumber) VALUES ('john.smith', 'Plastic Bottle', 'C', 2);
INSERT INTO Recycling (Username, ProductName, Category, RecycleNumber) VALUES ('john.smith', 'Plastic Bottle', 'C', 5);
INSERT INTO Recycling (Username, ProductName, Category) VALUES ('john.smith', 'Glass Bottle', 'C');

INSERT INTO Recycling (Username, ProductName, Category) VALUES ('brianj', 'Printer Paper', 'M');
INSERT INTO Recycling (Username, ProductName, Category) VALUES ('brianj', 'Printer Paper', 'M');
INSERT INTO Recycling (Username, ProductName, Category) VALUES ('brianj', 'Printer Paper', 'M');
INSERT INTO Recycling (Username, ProductName, Category) VALUES ('brianj', 'Laptop', 'E');

#should fail, invalid user
INSERT INTO Recycling (Username, ProductName, Category) VALUES ('test', 'Laptop', 'E');
#should fail, invalid category
INSERT INTO Recycling (Username, ProductName, Category) VALUES ('jdoe200', 'Food', 'F');

INSERT INTO RecyclingInstructions (ZipCode, Source, Instructions) VALUES (95112, 'https://www.santaclaraca.gov/home/showdocument?id=10107', 
'What Goes in the Recycling?

Paper Products
	- corrugated cardboard & paper boxes - large or multiple pieces should be flattened and/or cut
	- shredded paper - in a paper bag, secured with a staple
	- junk mail
	- newspaper
	- phonebooks & catalogs
	- dairy cartons
	- aseptic boxes - juice, soup & soy milk
	- books up to 40 lbs.

Glass Bottles & Jars

Aluminum & Metal
	- aerosol cans (empty)
	- cans & pans
	- scrap pieces up to 20 lbs.

Plastics Labeled 1-7
	- bottles & jars
	- tubs & trays
	- plastic bags - - Protect the environment by avoiding single-use bags. Reuse them when possible. When recycling multiple bags, stuff one bag full of the others; tie off the full bag before placing in the recycling.

NO GARBAGE OR ORGANICS
NO FOOD-SOILED PAPER OR PIZZA BOXES
NO STYROFOAM

HAZARDOUS WASTE HAS ITS PLACE.
Hazardous waste does NOT belong in any of the Mission Trail Waste Systems collection bins. Please call the Santa Clara County Household Hazardous Waste line at 408-299-7300 for information on proper disposal of items like paint, car batteries, fluorescent bulbs, toxic cleaners, poisons and sharps.');


INSERT INTO RecyclingInstructions (ZipCode, Source, Instructions) VALUES (10022, 'https://www1.nyc.gov/assets/dsny/site/services/recycling/what-to-recycle', 
'What to Recycle for Residents and Apartment Managers

Discover how to sort your recycling and what belongs in your bin. Please empty and rinse metal, glass, plastic and cartons containing food before recycling.

Metal (all kinds)
	- metal cans (soup, pet food, empty aerosol cans, empty paint cans, etc.)
	- aluminum foil and foil products (wrap and trays)
	- metal caps and lids
	- household metal items (wire hangers, pots, tools, curtain rods, small appliances that are mostly metal, certain vehicle license plates, etc.)
	- bulky metal items (large metal items, such as furniture, cabinets, large mostly metal appliances, DOES NOT INCLUDE electronic devices banned from disposal)

Glass
	- glass bottles and jars ONLY

Plastic (rigid plastics)
	- plastic bottles, jugs, and jars
	- rigid plastic caps and lids
	- rigid plastic food containers (yogurt, deli, hummus, dairy tubs, cookie tray inserts, “clamshell” containers, other rigid plastic take-out containers)
	- rigid plastic non-food containers (such as “blister-pack” and “clamshell” consumer packaging, acetate boxes)
	- rigid plastic housewares (flower pots, mixing bowls, plastic appliances, etc.)
	- bulk rigid plastic (crates, buckets, pails, furniture, large toys, large appliances, etc.)
Note:  Rigid plastic is any item that is mostly plastic resin—it is relatively inflexible and maintains its shape or form when bent.

Cartons
	- Food and beverage cartons
	- Drink boxes
	- Aseptic packaging (holds beverages and food: juice, milk and non-dairy milk products, soup, etc.)

Paper
	- newspapers, magazines, catalogs, phone books, mixed paper
	- white and colored paper (lined, copier, computer; staples are ok)
	- mail and envelopes (any color; window envelopes are ok)
	- receipts
	- paper bags (handles ok)
	- wrapping paper
	- soft-cover books (phone books, paperbacks, comics, etc.; no spiral bindings) (schools should follow their school  book recycling procedures)

Cardboard
	- cardboard egg cartons
	- cardboard trays
	- smooth cardboard (food and shoe boxes, tubes, file folders, cardboard from product packaging)
	- pizza boxes (remove and discard soiled liner; recycle little plastic supporter with rigid plastics)
	- paper cups (waxy lining ok if cups are empty and clean; recycle plastic lids with rigid plastics)
	- corrugated cardboard boxes (flattened and tied together with sturdy twine)

Not Accepted
	- Paper with heavy wax or plastic coating (candy wrappers, take-out and freezer containers, etc.)
	- Soiled or soft paper (napkins, paper towels, tissues)
	- Hardcover books (schools should follow their school  book recycling procedures)
	- Batteries
	- Electronic devices banned from disposal
	- Printer cartridges
	- Glass items other than glass bottles and jars (such as mirrors, light bulbs, ceramics, and glassware)
	- Window blinds
	- Foam plastic items (such as foam food service containers, cups and trays, foam protective packing blocks, and, and foam packing peanuts)
	- Flexible plastic items (such as single-serve food and drink squeezable pouches and tubes such as toothpaste, lotion, cosmetics, or sports balls such as basketballs, bowling balls, soccer balls, footballs, yoga balls)
	- Film plastic (such as plastic shopping bags and wrappers.) Bring plastic bags and film to participating stores for recycling
	- Cigarette lighters and butane gas lighters
	- Cassette and VHS tapes
	- CDs and DVDs
	- Pens and markers
	- “Tanglers” (such as cables, wires, cords, hoses)
	- Rigid plastic containers containing medical “sharps” or disposable razors
	- Containers that held dangerous or corrosive chemicals');




