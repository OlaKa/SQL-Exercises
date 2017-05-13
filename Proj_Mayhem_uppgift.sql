SET GLOBAL EVENT_SCHEDULER = ON;

CREATE EVENT end_of_auction
  ON SCHEDULE EVERY '1' DAY
  STARTS '2017-02-11 00:00:00'
DO
  INSERT INTO auction_history (Auction_ID,Product_ID,Customer_ID,Final_Bid,Date_Sold,Start_Date,End_Date,Start_Price,Accept_Price)
    SELECT auction.Auction_ID,auction.Product_ID,customer_bid.Customer_ID,MAX(customer_bid.Bid) AS MaxBid,
      customer_bid.Bid_Date, auction.Start_Date, auction.End_Date, auction.Start_Price,Accept_Price FROM auction
      INNER JOIN customer_bid ON customer_bid.Auction_ID = auction.Auction_ID
    WHERE auction.End_Date < '2015-03-31'
    GROUP BY auction.Auction_ID;
  
  