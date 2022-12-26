CREATE TABLE "campaign" (
    "cf_id" int   NOT NULL,
    "contact_id" int   NOT NULL,
    "company_name" varchar(100)   NOT NULL,
    "description" text   NOT NULL,
    "goal" numeric(10,2)   NOT NULL,
    "pledged" numeric(10,2)   NOT NULL,
    "outcome" varchar(50)   NOT NULL,
    "backers_count" int   NOT NULL,
    "country" varchar(10)   NOT NULL,
    "currency" varchar(10)   NOT NULL,
    "launch_date" date   NOT NULL,
    "end_date" date   NOT NULL,
    "category_id" varchar(10)   NOT NULL,
    "subcategory_id" varchar(10)   NOT NULL,
    CONSTRAINT "pk_campaign" PRIMARY KEY (
        "cf_id"
     )
);

CREATE TABLE "category" (
    "category_id" varchar(10)   NOT NULL,
    "category_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_category" PRIMARY KEY (
        "category_id"
     )
);

CREATE TABLE "subcategory" (
    "subcategory_id" varchar(10)   NOT NULL,
    "subcategory_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_subcategory" PRIMARY KEY (
        "subcategory_id"
     )
);

CREATE TABLE "contacts" (
    "contact_id" int   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "email" varchar(100)   NOT NULL,
    CONSTRAINT "pk_contacts" PRIMARY KEY (
        "contact_id"
     )
	);
	
CREATE TABLE "backer" (
    "cf_id" int   NOT NULL,
    "backer_id" varchar(50)   NOT NULL,
    "firstname" varchar(50)   NOT NULL,
	"lastname" varchar(50)   NOT NULL,
    "email" varchar(100)   NOT NULL,
    CONSTRAINT "pk_backer" PRIMARY KEY (
        "backer_id"
     )
	);
	
SELECT backers_count, outcome, cf_id
FROM campaign
WHERE outcome = 'live'
ORDER BY cf_id DESC;

SELECT contacts.first_name, contacts.last_name, contacts.email, campaign.contact_id, campaign.goal - campaign.pledged AS remaining 
INTO email_contacts_remaining_goal_amount
FROM campaign
LEFT JOIN contacts
ON campaign.contact_id = contacts.contact_id
WHERE outcome = 'live' 


select eg.email, eg.first_name, eg.last_name, campaign.cf_id, campaign.company_name, campaign.description, campaign.end_date, eg.remaining
INTO email_backers_remaining_goal_amount
FROM email_contacts_remaining_goal_amount as eg
INNER JOIN campaign
ON (campaign.contact_id = eg.contact_id)
--RIGHT JOIN backer
--ON (campaign.cf_id = backer.cf_id)
WHERE outcome = 'live'
