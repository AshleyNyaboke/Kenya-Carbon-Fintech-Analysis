let
    Source = Csv.Document(File.Contents("C:\Users\Administrator\Documents\Kenya-Carbon-Fintech-Analysis\data\mpesa_carbon_payouts.csv"),[Delimiter=",", Columns=9, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Transaction_ID", type text}, {"Date", type date}, {"Farmer_ID", type text}, {"County", type text}, {"Sub_County", type text}, {"Trees_Planted", Int64.Type}, {"Survival_Rate_Pct", type number}, {"Mpesa_Disbursement_KES", Int64.Type}, {"Carbon_Sequestration_MT", type number}}),
    #"Added Conditional Column" = Table.AddColumn(#"Changed Type", "Custom", each if [Trees_Planted] = 0 then "Maintenance Payout" else "Initial planning payout"),
    #"Renamed Columns" = Table.RenameColumns(#"Added Conditional Column",{{"Custom", "Transaction Type"}})
in
    #"Renamed Columns"