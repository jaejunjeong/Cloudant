# Export your CLOUDANTURL(Credential from Cloudant)
export CLOUDANTURL="Insert URL"

# Export json at the to CLOUDANT
curl -XPOST $CLOUDANTURL/movies/_bulk_docs -Hcontent-type:application/json -d @movie.json

# Check
curl $CLOUDANTURL

# Check the DB
curl $CLOUDANTURL/_all_dbs

# Create the DB 'animals'
curl -X PUT $CLOUDANTURL/animals
curl -X PUT $CLOUDANTURL/planets

# Check wether DB created
curl $CLOUDANTURL/_all_dbs

# Delete the DB 'animals'
curl -X DELETE $CLOUDANTURL/animals

# Insert the document (You can use POST insetead of PUT without id)
curl -X PUT $CLOUDANTURL/planets/"1" -d '{ 
    "name" : "Mercury" ,
    "position_from_sum" :1 
     }'
     
# Check the insertion
curl -X GET $CLOUDANTURL/planets/1 

# Note the rev
# Replace the "_rev" below value with noted rev(Update)
curl -X PUT $CLOUDANTURL/planets/1 -d '{ 
    "name" : "Mercury" ,
    "position_from_sum" :1,
    "revolution_time":"88 days",
    "_rev":"1-3fb3ccfe80573e1ae334f0cfa7304f6c"
    }'

# Note the rev again
# Replace the "_rev" below value with noted rev(Update)
curl -X PUT $CLOUDANTURL/planets/1 -d '{
    "name": "Mercury",
    "position_from_sum": 1,
    "revolution_time": "88 days",
    "rotation_time": "59 days",
    "_rev": "1-3fb3ccfe80573e1ae334f0cfa7304f6c"
}'

# Note the rev again
# Replace the "_rev" below value with noted rev(Delete)
curl -X DELETE $CLOUDANTURL/planets/1?rev=2-de9fdd2d971e377c5db2d6425cb38ff1

# Verify the delete
curl -X GET $CLOUDANTURL/planets/1 

## Diamond DB
# Populate Diamond DB
curl -X DELETE $CLOUDANTURL/diamonds
curl -X PUT $CLOUDANTURL/diamonds

curl -X PUT $CLOUDANTURL/diamonds/1 -d '{
    "carat": 0.31,
    "cut": "Ideal",
    "color": "J",
    "clarity": "SI2",
    "depth": 62.2,
    "table": 54,
    "price": 339
  }'
  
curl -X PUT $CLOUDANTURL/diamonds/2 -d '{
    "carat": 0.2,
    "cut": "Premium",
    "color": "E",
    "clarity": "SI2",
    "depth": 60.2,
    "table": 62,
    "price": 351
  
  }'
  
curl -X PUT $CLOUDANTURL/diamonds/3 -d '{
    "carat": 0.32,
    "cut": "Premium",
    "color": "E",
    "clarity": "I1",
    "depth": 60.9,
    "table": 58,
    "price": 342

  }'
  
  
curl -X PUT $CLOUDANTURL/diamonds/4 -d '{
    "carat": 0.3,
    "cut": "Good",
    "color": "J",
    "clarity": "SI1",
    "depth": 63.4,
    "table": 54,
    "price": 349

  }'
  
curl -X PUT $CLOUDANTURL/diamonds/5 -d '{
    "carat": 0.3,
    "cut": "Good",
    "color": "J",
    "clarity": "SI1",
    "depth": 63.8,
    "table": 56,
    "price": 347

  }'
  
curl -X PUT $CLOUDANTURL/diamonds/6 -d '{
    "carat": 0.3,
    "cut": "Very Good",
    "color": "J",
    "clarity": "SI1",
    "depth": 62.7,
    "table": 59,
    "price": 349
  }'
  
curl -X PUT $CLOUDANTURL/diamonds/7 -d '{
    "carat": 0.3,
    "cut": "Good",
    "color": "I",
    "clarity": "SI2",
    "depth": 63.3,
    "table": 56,
    "price": 343
  }'
  
curl -X PUT $CLOUDANTURL/diamonds/8 -d '{
    "carat": 0.23,
    "cut": "Very Good",
    "color": "E",
    "clarity": "VS2",
    "depth": 63.8,
    "table": 55,
    "price": 339
  }'
  
curl -X PUT $CLOUDANTURL/diamonds/9 -d '{
    "carat": 0.23,
    "cut": "Very Good",
    "color": "H",
    "clarity": "VS1",
    "depth": 61,
    "table": 57,
    "price": 323
  }'
  
curl -X PUT $CLOUDANTURL/diamonds/10 -d '{
    "carat": 0.31,
    "cut": "Very Good",
    "color": "J",
    "clarity": "SI1",
    "depth": 59.4,
    "table": 62,
    "price": 346
  }'
  
# Query for diamond with _id 1
  curl -X POST $CLOUDANTURL/diamonds/_find \
-H"Content-Type: application/json" \
-d'{ 
    "selector":
        {
            "_id":"1"
        }
    }'

# Query for diamonds with carat size of 0.3
curl -X POST $CLOUDANTURL/diamonds/_find \
-H"Content-Type: application/json" \
-d'{ "selector":
        {
            "carat":0.3
        }
    }'

# Query for diamonds with carat size of 0.3 and specific fields
curl -X POST $CLOUDANTURL/diamonds/_find \
-H"Content-Type: application/json" \
-d'{ "selector":
        {
            "carat":0.3
        }, 
        "fields" ["price","_id"]
    }'

# Query for diamonds with price more than 345
curl -X POST $CLOUDANTURL/diamonds/_find \
-H"Content-Type: application/json" \
-d'{ "selector":
        {
            "price":
                {
                    "$gt":345
                }
        }
    }'

# Create an index on the key “price”
curl -X POST $CLOUDANTURL/diamonds/_index \
-H"Content-Type: application/json" \
-d'{
    "index": {
        "fields": ["price"]
    }
}'

# Check the price query run faster
curl -X POST $CLOUDANTURL/diamonds/_find \
-H"Content-Type: application/json" \
-d'{ "selector":
        {
            "price":
                {
                    "$gt":345
                }
        }
    }'
