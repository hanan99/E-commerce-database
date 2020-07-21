CREATE TABLE [Orders] (
  [id] int PRIMARY KEY IDENTITY (1,1),
  [user_id] int UNIQUE NOT NULL,
  [status_code] int,
  [created_at_datetime] nvarchar(255),
  [packed_datetime] nvarchar(255),
  [delivered_datetime] nvarchar(255),
  [cancelled_datetime] nvarchar(255),
  [returned_datetime] nvarchar(255),
  [shipping_charge] float,
  [other_order_details] nvarchar(255)
  )
GO

CREATE TABLE [order_items] (
  [order_id] int,
  [product_id] int,
  [quantity] int,
  [discount] float,
  [item_shipping_charge] float
)
GO

CREATE TABLE [products] (
  [id] int PRIMARY KEY IDENTITY (1,1),
  [name] nvarchar(255),
  [merchant_id] int NOT NULL,
  [price] float,
  [status] nvarchar(255),
  [created_at] nvarchar(255),
  [category_id] int,
  [product_rate] float,
  CONSTRAINT CHK_Rating CHECK (product_rate <= 5 AND product_rate >= 0)
)
GO

CREATE TABLE [users] (
  [id] int PRIMARY KEY IDENTITY (1,1),
  [full_name] nvarchar(255),
  [email] nvarchar(255) UNIQUE,
  [gender] nvarchar(255),
  [date_of_birth] nvarchar(255),
  [created_at] nvarchar(255),
  [country_code] int
)
GO

CREATE TABLE [merchants] (
  [id] int PRIMARY KEY IDENTITY (1,1),
  [admin_id] int,
  [merchant_name] nvarchar(255),
  [created_at] nvarchar(255)
)
GO

CREATE TABLE [categories] (
  [id] int PRIMARY KEY IDENTITY (1,1),
  [cat_name] nvarchar(255),
  [parent_id] int
)
GO

CREATE TABLE [countries] (
  [code] int PRIMARY KEY IDENTITY (1,1),
  [name] nvarchar(255),
  [continent_name] nvarchar(255)
)
GO

CREATE TABLE [order_status](
	[id] int PRIMARY KEY IDENTITY (1,1),
	[status_state] nvarchar(255)
)
GO

ALTER TABLE [orders] ADD FOREIGN KEY ([status_code]) REFERENCES [order_status] ([id])
GO

ALTER TABLE [orders] ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
GO

ALTER TABLE [order_items] ADD FOREIGN KEY ([order_id]) REFERENCES [orders] ([id])
GO

ALTER TABLE [order_items] ADD FOREIGN KEY ([product_id]) REFERENCES [products] ([id])
GO

ALTER TABLE [products] ADD FOREIGN KEY ([merchant_id]) REFERENCES [merchants] ([id])
GO

ALTER TABLE [products] ADD FOREIGN KEY ([category_id]) REFERENCES [categories] ([id])
GO

ALTER TABLE [categories] ADD FOREIGN KEY ([parent_id]) REFERENCES [categories] ([id])
GO

ALTER TABLE [users] ADD FOREIGN KEY ([country_code]) REFERENCES [countries] ([code])
GO

ALTER TABLE [merchants] ADD FOREIGN KEY ([admin_id]) REFERENCES [users] ([id])
GO

