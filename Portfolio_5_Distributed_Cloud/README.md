# Portfolio 5: Distributed and Cloud Database

## 1. Case Study

**System Name:** University Library Management System

This portfolio builds on the University Library Management System developed in the previous portfolios. I used MongoDB Atlas to deploy the NoSQL book collection to a cloud environment and test whether the migrated data could be retrieved successfully.

The work covers cloud database setup, data migration, replication and query testing. It also examines the role of replication and the difference between replication and sharding.

## 2. Cloud Database Deployment

I created a MongoDB Atlas cluster named `LibraryCloudCluster` for the project.

The deployment configuration was as follows:

- **Cloud provider:** Amazon Web Services (AWS)
- **Region:** Paris, France (`eu-west-3`)
- **MongoDB version:** 8.0.34
- **Cluster tier:** Free
- **Deployment type:** Three-node replica set

The cloud database is named `university_library_nosql`, and its `books` collection contains the book documents migrated from the local MongoDB Community Server database used in Portfolio 4.

## 3. Data Migration

I exported the local `books` collection to a JSON file and imported the exported documents into the corresponding collection in MongoDB Atlas.

The migration transferred all three book documents without requiring me to recreate them manually. I kept the local database so that the cloud version could be tested separately from the original implementation.

After the import, I checked the cloud collection to confirm that the three documents were present.

## 4. Cloud Query Testing

I ran three queries against the cloud `books` collection using MongoDB Compass.

| Test | Query purpose | Expected result | Observed result |
|---|---|---:|---:|
| Category query | Retrieve books in the Database Systems category | 2 documents | 2 documents |
| Available-copy query | Retrieve books containing available physical copies | 2 documents | 2 documents |
| On-loan query | Retrieve books containing copies currently on loan | 1 document | 1 document |

All three queries returned the expected number of documents. I also checked the collection and confirmed that all three book documents were present after migration.

These results confirm that the imported data was accessible in Atlas and that the three queries returned the expected document counts for the sample records.

## 5. Replication and Availability

The MongoDB Atlas cluster overview showed three replica-set members: one primary and two secondary nodes.

The primary handles write operations, while the secondary nodes replicate data from the primary. Having multiple replica-set members provides data redundancy and helps the replica set maintain availability if a member becomes unavailable, provided the remaining members can maintain the required quorum and elect a primary where necessary.

I captured the cluster overview as evidence of the configured replica-set architecture. I did not perform a controlled failover test, so I have not treated the configuration alone as proof that failover was successfully tested.

## 6. Consistency and Sharding

MongoDB replica sets maintain copies of data across their members. Read and write concerns can be configured to determine the consistency and durability guarantees required for database operations.

For this project, I used MongoDB Compass with its standard connection and query behaviour. I did not run separate tests comparing different read or write concerns, so no conclusions were drawn about their effects in this deployment.

Sharding is another MongoDB feature that distributes data across multiple shards to support horizontal scaling. I did not configure sharding for this portfolio. The deployment used a replica set, which was sufficient for the scope of the exercise but does not demonstrate a sharded database.

## 7. Limitations

The project used a Free-tier Atlas deployment and contained only three book documents. The tests focused on importing the data and retrieving it through queries rather than measuring performance under a realistic workload.

I did not carry out a controlled failover test, configure sharding, run a load test or compare query performance between the local and cloud databases. These would be useful areas for further testing.

## 8. Evidence

The `evidence` folder contains the following screenshots from the implementation:

1. `01_atlas_cloud_books_import.png` shows the cloud collection after the data import.
2. `02_atlas_category_query.png` shows the category query results.
3. `03_atlas_available_copies_query.png` shows the available-copy query results.
4. `04_atlas_on_loan_query.png` shows the on-loan query results.
5. `05_atlas_replica_set.png` shows the Atlas replica-set members and their roles.

## 9. Conclusion

In this portfolio, I migrated the three-book collection from the local MongoDB database to MongoDB Atlas and tested the cloud collection using three queries. The queries returned the expected document counts, and the collection check confirmed that all three documents were present after migration.

The Atlas overview also showed a three-node replica-set configuration. The work provided practical experience with cloud database deployment, data migration and query testing, while highlighting the difference between configuring replication and actually testing failover. It also showed that replication and sharding serve different purposes in MongoDB.