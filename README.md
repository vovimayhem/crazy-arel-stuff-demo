# Crazy Arel + Postgres Stuff Demo:

## 1: System Requirements:
 - Docker for Mac, Windows or Linux


## 2: Running the Demos:

This project is made to run as soon as it is cloned from github, using Docker Compose.

After you've cloned this repo, you should be able to run the following examples
using the described commands "as it is"... no special knowledge required.

The first time you run any of the examples will spend a couple of minutes
building a development environment (a docker image) in which the rails app will
run in the successive examples. It will also check for the demo database, and
setup one if not already present.

### 2.1: Mass-Inserting Demo:

The mass-insertion demo is implemented as a Thor task. Type the following
command:

```bash
docker-compose run --rm app thor data:add_inventory
```

### 2.1.1: Initial catalog:

The first time you run this example, the demo will ask you to create some
catalog entries.

It will first ask you for a number of "shelves" (in which we'll store the
thousands of items we'll massively create later on)... type in "40" and `ENTER`:

```bash
How many new shelves would you wish to add? 40
```

Next, it will ask how many product categories you wish to add... type in "20"
 and `ENTER`:

```bash
How many new categories would you wish to add? 20
```

Then it will ask you how many products (not items) do you wish to add...
type in "40" and `ENTER`:

```bash
How many new products would you wish to add? 40
```

By this point, your'e ready for the next step, which is this what this demo is
all about...

### 2.2.2: The actual mass insertion

When there is some catalog, the demo will go directly to create an "inbound
order" which will add items into the inventory.

It will first ask you how many different products will be added to the
inventory... type in "40" and hit `ENTER`:

```bash
How many different products you wish to add to the order? 40
```

Next, it will ask you how many items (quantity) per product you'll be adding to
the inventory... try something big... type in "10000" and hit `ENTER` - THAT
WILL BE 400,000 RECORDS THAT WILL BE CREATED:

```bash
How many items do you want per product? 10000
```

It generate one "inbound log" for each different product before stopping for the
last time to confirm the mass insertion... Hit `ENTER` to proceed

```bash
Hit ENTER to proceed...
```

This is the important step. Check out how much time your system takes to
generate 400,000 records - all of them distributed in the available racks and
each one of them having it's own rank (order) inside the shelf. On my system, it
takes around 14 seconds to do this... that's 20000 records per second.
