-- Practice: Carnival
-- 1.Create a trigger for when a new Sales record is added, set the purchase date 
-- to 3 days from the current date.
CREATE FUNCTION set_pickup_date()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
  --Trigger function logic--
  UPDATE sales
    SET pickup_date = NEW.purchase_date + integer
  '3'
    WHERE sales.sales_id = new.



  CREATE OR REPLACE FUNCTION set_purchase_date
  ()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
AS $$
  BEGIN
    UPDATE sales 
	SET purchase_date = current_date + 3
	WHERE sales.sale_id = NEW.sale_id;
    RETURN NULL;
  END;
  $$
  CREATE TRIGGER new_sale_added
	AFTER
  INSERT
	ON
  sales
  FOR
  EACH
  ROW
  EXECUTE PROCEDURE set_purchase_date
  ();

  INSERT INTO sales
    (sales_type_id, vehicle_id, employee_id, dealership_id, price, invoice_number)
  VALUES
    (1, 11, 111, 111, 10111, 101010101),
    (1, 12, 111, 111, 34332, 202020202),
    (1, 13, 111, 111, 64728, 303030303),
    (1, 14, 111, 111, 29512, 404040404);

  SELECT *
  FROM sales
  ORDER BY sale_id DESC;
  -- 2.Create a trigger for updates to the Sales table. If the pickup date is on or 
  -- before the purchase date, set the pickup date to 7 days after the purchase date.
  --  If the pickup date is less than 7 days out from the purchase date, day 4 additional 
  --  days to the pickup date.
  CREATE OR REPLACE FUNCTION conditionally_set_pickup_date
  () 
  RETURNS TRIGGER 
  LANGUAGE PlPGSQL
AS $$
  BEGIN
    IF NEW.pickup_date > NEW.purchase_date AND NEW.pickup_date <= NEW.purchase_date  + integer '7' THEN
	  NEW.pickup_date := NEW.pickup_date + integer '4';
  ELSIF NEW.pickup_date <= NEW.purchase_date THEN
	  NEW.pickup_date := NEW.purchase_date + integer '7';
END
IF;
  
  RETURN NEW;
END;
$$

CREATE TRIGGER update_sale_made_pickup_date
  BEFORE
UPDATE
  ON sales
  FOR EACH ROW
EXECUTE PROCEDURE conditionally_set_pickup_date
();


UPDATE sales
SET pickup_date = purchase_date + 1
WHERE sale_id > 1008;

SELECT *
FROM sales
ORDER BY sale_id DESC;