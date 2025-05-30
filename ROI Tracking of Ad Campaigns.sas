
%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u64242476/ad_campaign_data.csv';

PROC IMPORT DATAFILE=REFFILE
    DBMS=CSV
    OUT=WORK.IMPORT
    REPLACE;
    GETNAMES=YES;
    GUESSINGROWS=MAX;
RUN;


PROC CONTENTS DATA=WORK.IMPORT; 
RUN;


%web_open_table(WORK.IMPORT);


DATA ad_roi;
    SET WORK.IMPORT;

    ROI = .;
    IF AdSpend > 0 THEN ROI = (Revenue - AdSpend) / AdSpend;

    Format StartDate EndDate DATE9.;
    Campaign_Duration_Days = INTCK('day', StartDate, EndDate);
RUN;


    CREATE TABLE campaign_summary AS
    SELECT 
        CampaignID,
        Channel,
        AdType,
        Region,
        SUM(Impressions) AS Total_Impressions,
        SUM(Clicks) AS Total_Clicks,
        SUM(Conversions) AS Total_Conversions,
        SUM(AdSpend) AS Total_AdSpend,
        SUM(Revenue) AS Total_Revenue,
        /* Calculating ROI */
        CASE 
            WHEN SUM(AdSpend) > 0 
            THEN (SUM(Revenue) - SUM(AdSpend)) / SUM(AdSpend)
            ELSE . 
        END AS ROI FORMAT=percent8.2
    FROM ad_roi
    GROUP BY CampaignID, Channel, AdType, Region
    ORDER BY ROI DESC;
QUIT;


PROC PRINT DATA=campaign_summary LABEL NOOBS;
    TITLE "ROI Tracking Report by Campaign";
    VAR CampaignID Channel AdType Region Total_Impressions Total_Clicks Total_Conversions 
        Total_AdSpend Total_Revenue ROI;
RUN;


ODS GRAPHICS ON;
PROC SGPLOT DATA=campaign_summary;
    TITLE "Distribution of Campaign ROI";
    HISTOGRAM ROI / BINWIDTH=0.1;
    XAXIS LABEL="ROI";
    YAXIS LABEL="Number of Campaigns";
RUN;
ODS GRAPHICS OFF;
