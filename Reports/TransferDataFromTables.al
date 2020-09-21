report 50000 MyReport
{
    UsageCategory = Administration;
    ApplicationArea = All;

    /*
trigger OnPostReport()
var
begin
            IF "AZ Setup".FindSet THEN
                REPEAT
                    "AUZ AZ Setup".Init;
                    "AUZ AZ Setup"."Primary Key" := "AZ Setup"."Primary Key";
                    "AUZ AZ Setup"."Sales Accrual Enabled" := "AZ Setup"."Sales Accrual Enabled";
                    "AUZ AZ Setup"."Sales Accrual Bal. Account No." := "AZ Setup"."Sales Accrual Bal. Account No.";
                    "AUZ AZ Setup"."Sales To Accrual Account No." := "AZ Setup"."Sales To Accrual Account No.";
                    "AUZ AZ Setup"."Sales From Accrual Account No." := "AZ Setup"."Sales From Accrual Account No.";
                    "AUZ AZ Setup"."Check Service Period" := "AZ Setup"."Check Service Period";
                    "AUZ AZ Setup"."Service Accrual Enabled" := "AZ Setup"."Service Accrual Enabled";
                    "AUZ AZ Setup"."Serv. Accrual Bal. Account No." := "AZ Setup"."Serv. Accrual Bal. Account No.";
                    "AUZ AZ Setup"."Service To Accrual Account No." := "AZ Setup"."Service To Accrual Account No.";
                    "AUZ AZ Setup"."Serv. From Accrual Account No." := "AZ Setup"."Serv. From Accrual Account No.";
                    "AUZ AZ Setup"."AZ Solutions" := "AZ Setup"."AZ Solutions";
                    "AUZ AZ Setup"."Sales Chart G/L Account Filter" := "AZ Setup"."Sales Chart G/L Account Filter";
                    "AUZ AZ Setup"."Sales Chart Budget Name" := "AZ Setup"."Sales Chart Budget Name";
                    "AUZ AZ Setup"."Expenses Entries No. Series" := "AZ Setup"."Expenses Entries No. Series";
                    "AUZ AZ Setup".Insert;
                UNTIL "AZ Setup".next = 0;



            IF "Customer Resp. Hours Approver".FindSet THEN
                REPEAT
                    "AUZ Customer Resp. Hours Approver".Init;
                    "AUZ Customer Resp. Hours Approver"."Customer Responsible" := "Customer Resp. Hours Approver"."Customer Responsible";
                    "AUZ Customer Resp. Hours Approver"."Job No." := "Customer Resp. Hours Approver"."Job No.";
                    "AUZ Customer Resp. Hours Approver"."Job Task No." := "Customer Resp. Hours Approver"."Job Task No.";
                    "AUZ Customer Resp. Hours Approver"."Case No." := "Customer Resp. Hours Approver"."Case No.";
                    "AUZ Customer Resp. Hours Approver"."Job Description" := "Customer Resp. Hours Approver"."Job Description";
                    "AUZ Customer Resp. Hours Approver"."Job Task Description" := "Customer Resp. Hours Approver"."Job Task Description";
                    "AUZ Customer Resp. Hours Approver".Insert;
                UNTIL "Customer Resp. Hours Approver".next = 0;



            IF "Invoicing Period".FindSet THEN
                REPEAT
                    "AUZ Invoicing Period".Init;
                    "AUZ Invoicing Period"."Code" := "Invoicing Period"."Code";
                    "AUZ Invoicing Period"."Description" := "Invoicing Period"."Description";
                    "AUZ Invoicing Period".Insert;
                UNTIL "Invoicing Period".next = 0;



            IF "Tables To Clean".FindSet THEN
                REPEAT
                    "AUZ Tables To Clean".Init;
                    "AUZ Tables To Clean"."ID" := "Tables To Clean"."ID";
                    "AUZ Tables To Clean"."Table Name" := "Tables To Clean"."Table Name";
                    "AUZ Tables To Clean"."Table Caption" := "Tables To Clean"."Table Caption";
                    "AUZ Tables To Clean"."Number of Records" := "Tables To Clean"."Number of Records";
                    "AUZ Tables To Clean"."Delete" := "Tables To Clean"."Delete";
                    "AUZ Tables To Clean"."Delete 2" := "Tables To Clean"."Delete 2";
                    "AUZ Tables To Clean".Insert;
                UNTIL "Tables To Clean".next = 0;



            IF "Sales Chart Setup".FindSet THEN
                REPEAT
                    "AUZ Sales Chart Setup".Init;
                    "AUZ Sales Chart Setup"."User ID" := "Sales Chart Setup"."User ID";
                    "AUZ Sales Chart Setup"."Dimension Code" := "Sales Chart Setup"."Dimension Code";
                    "AUZ Sales Chart Setup"."Dimension Filter" := "Sales Chart Setup"."Dimension Filter";
                    "AUZ Sales Chart Setup"."Dimension Filter 2" := "Sales Chart Setup"."Dimension Filter 2";
                    "AUZ Sales Chart Setup"."Dimension Filter 3" := "Sales Chart Setup"."Dimension Filter 3";
                    "AUZ Sales Chart Setup"."Dimension Filter 4" := "Sales Chart Setup"."Dimension Filter 4";
                    "AUZ Sales Chart Setup"."Chart View" := "Sales Chart Setup"."Chart View";
                    "AUZ Sales Chart Setup".Insert;
                UNTIL "Sales Chart Setup".next = 0;



            IF "Object Compare".FindSet THEN
                REPEAT
                    "AUZ Object Compare".Init;
                    "AUZ Object Compare"."Compare" := "Object Compare"."Compare";
                    "AUZ Object Compare"."Type" := "Object Compare"."Type";
                    "AUZ Object Compare"."ID" := "Object Compare"."ID";
                    "AUZ Object Compare"."Name" := "Object Compare"."Name";
                    "AUZ Object Compare"."Modified" := "Object Compare"."Modified";
                    "AUZ Object Compare"."Compiled" := "Object Compare"."Compiled";
                    "AUZ Object Compare"."Date" := "Object Compare"."Date";
                    "AUZ Object Compare"."Time" := "Object Compare"."Time";
                    "AUZ Object Compare"."Version List" := "Object Compare"."Version List";
                    "AUZ Object Compare"."Caption" := "Object Compare"."Caption";
                    "AUZ Object Compare"."Status" := "Object Compare"."Status";
                    "AUZ Object Compare".Insert;
                UNTIL "Object Compare".next = 0;



            IF "Object Compared".FindSet THEN
                REPEAT
                    "AUZ Object Compared".Init;
                    "AUZ Object Compared"."Line No." := "Object Compared"."Line No.";
                    "AUZ Object Compared"."Type" := "Object Compared"."Type";
                    "AUZ Object Compared"."ID" := "Object Compared"."ID";
                    "AUZ Object Compared"."Name" := "Object Compared"."Name";
                    "AUZ Object Compared"."Modified" := "Object Compared"."Modified";
                    "AUZ Object Compared"."Compiled" := "Object Compared"."Compiled";
                    "AUZ Object Compared"."Date" := "Object Compared"."Date";
                    "AUZ Object Compared"."Time" := "Object Compared"."Time";
                    "AUZ Object Compared"."Version List" := "Object Compared"."Version List";
                    "AUZ Object Compared"."Caption" := "Object Compared"."Caption";
                    "AUZ Object Compared"."Type 2" := "Object Compared"."Type 2";
                    "AUZ Object Compared"."ID 2" := "Object Compared"."ID 2";
                    "AUZ Object Compared"."Name 2" := "Object Compared"."Name 2";
                    "AUZ Object Compared"."Modified 2" := "Object Compared"."Modified 2";
                    "AUZ Object Compared"."Compiled 2" := "Object Compared"."Compiled 2";
                    "AUZ Object Compared"."Date 2" := "Object Compared"."Date 2";
                    "AUZ Object Compared"."Time 2" := "Object Compared"."Time 2";
                    "AUZ Object Compared"."Version List 2" := "Object Compared"."Version List 2";
                    "AUZ Object Compared"."Caption 2" := "Object Compared"."Caption 2";
                    "AUZ Object Compared"."Status" := "Object Compared"."Status";
                    "AUZ Object Compared".Insert;
                UNTIL "Object Compared".next = 0;


            IF "Accounting Setup".FindSet THEN
                REPEAT
                    "AUZ Accounting Setup".Init;
                    "AUZ Accounting Setup"."Primary Key" := "Accounting Setup"."Primary Key";
                    "AUZ Accounting Setup"."Sales Accrual Enabled" := "Accounting Setup"."Sales Accrual Enabled";
                    "AUZ Accounting Setup"."Purchase Accrual Enabled" := "Accounting Setup"."Purchase Accrual Enabled";
                    "AUZ Accounting Setup".Insert;
                UNTIL "Accounting Setup".next = 0;


            IF "External File Management Setup".FindSet THEN
                REPEAT
                    "AUZ External File Management Setup".Init;
                    "AUZ External File Management Setup"."Primary Key" := "External File Management Setup"."Primary Key";
                    "AUZ External File Management Setup"."Save to Database" := "External File Management Setup"."Save to Database";
                    "AUZ External File Management Setup"."File Directory" := "External File Management Setup"."File Directory";
                    "AUZ External File Management Setup"."Run on Client" := "External File Management Setup"."Run on Client";
                    "AUZ External File Management Setup"."Copy Files to Posted Shpt." := "External File Management Setup"."Copy Files to Posted Shpt.";
                    "AUZ External File Management Setup"."Copy Files to Posted Inv." := "External File Management Setup"."Copy Files to Posted Inv.";
                    "AUZ External File Management Setup"."Copy Files to Posted Cr. Memo" := "External File Management Setup"."Copy Files to Posted Cr. Memo";
                    "AUZ External File Management Setup".Insert;
                UNTIL "External File Management Setup".next = 0;



            IF "External File".FindSet THEN
                REPEAT
                    "AUZ External File".Init;
                    "AUZ External File"."Entry No." := "External File"."Entry No.";
                    "AUZ External File"."Record ID" := "External File"."Record ID";
                    "AUZ External File"."File Name" := "External File"."File Name";
                    "AUZ External File"."File Extension" := "External File"."File Extension";
                    "AUZ External File"."Uploaded by User" := "External File"."Uploaded by User";
                    "AUZ External File"."Uploaded Date" := "External File"."Uploaded Date";
                    "AUZ External File"."File" := "External File"."File";
                    "AUZ External File"."Source Table" := "External File"."Source Table";
                    "AUZ External File"."Source Type" := "External File"."Source Type";
                    "AUZ External File"."Soruce No." := "External File"."Soruce No.";
                    "AUZ External File"."Source Line No." := "External File"."Source Line No.";
                    "AUZ External File"."Description" := "External File"."Description";
                    "AUZ External File".Insert;
                UNTIL "External File".next = 0;



            IF "Distribution Setup".FindSet THEN
                REPEAT
                    "AUZ Distribution Setup".Init;
                    "AUZ Distribution Setup"."Primary Key" := "Distribution Setup"."Primary Key";
                    "AUZ Distribution Setup"."Job Queue E-Mail" := "Distribution Setup"."Job Queue E-Mail";
                    "AUZ Distribution Setup"."BCC E-Mail" := "Distribution Setup"."BCC E-Mail";
                    "AUZ Distribution Setup".Insert;
                UNTIL "Distribution Setup".next = 0;



            IF "Distribution Log Entry".FindSet THEN
                REPEAT
                    "AUZ Distribution Log Entry".Init;
                    "AUZ Distribution Log Entry"."Entry No." := "Distribution Log Entry"."Entry No.";
                    "AUZ Distribution Log Entry"."Document Type" := "Distribution Log Entry"."Document Type";
                    "AUZ Distribution Log Entry"."Document No." := "Distribution Log Entry"."Document No.";
                    "AUZ Distribution Log Entry"."Last Document Entry" := "Distribution Log Entry"."Last Document Entry";
                    "AUZ Distribution Log Entry"."Date" := "Distribution Log Entry"."Date";
                    "AUZ Distribution Log Entry"."Error Message" := "Distribution Log Entry"."Error Message";
                    "AUZ Distribution Log Entry"."Error Message 2" := "Distribution Log Entry"."Error Message 2";
                    "AUZ Distribution Log Entry"."Error Message 3" := "Distribution Log Entry"."Error Message 3";
                    "AUZ Distribution Log Entry"."Error Message 4" := "Distribution Log Entry"."Error Message 4";
                    "AUZ Distribution Log Entry".Insert;
                UNTIL "Distribution Log Entry".next = 0;


            IF "Service Copy Setup".FindSet THEN
                REPEAT
                    "AUZ Service Copy Setup".Init;
                    "AUZ Service Copy Setup"."Primary Key" := "Service Copy Setup"."Primary Key";
                    "AUZ Service Copy Setup"."Exact Cost Reversing Mandatory" := "Service Copy Setup"."Exact Cost Reversing Mandatory";
                    "AUZ Service Copy Setup".Insert;
                UNTIL "Service Copy Setup".next = 0;


            IF "ABA File Transfer Setup".FindSet THEN
                REPEAT
                    "AUZ ABA File Transfer Setup".Init;
                    "AUZ ABA File Transfer Setup"."File Type Code" := "ABA File Transfer Setup"."File Type Code";
                    "AUZ ABA File Transfer Setup"."File Format Code" := "ABA File Transfer Setup"."File Format Code";
                    "AUZ ABA File Transfer Setup"."FTP Setup Code" := "ABA File Transfer Setup"."FTP Setup Code";
                    "AUZ ABA File Transfer Setup"."Forward by Email" := "ABA File Transfer Setup"."Forward by Email";
                    "AUZ ABA File Transfer Setup"."Sender Email" := "ABA File Transfer Setup"."Sender Email";
                    "AUZ ABA File Transfer Setup"."Recipient Email" := "ABA File Transfer Setup"."Recipient Email";
                    "AUZ ABA File Transfer Setup"."Auto Transfer Export Entries" := "ABA File Transfer Setup"."Auto Transfer Export Entries";
                    "AUZ ABA File Transfer Setup".Insert;
                UNTIL "ABA File Transfer Setup".next = 0;



            IF "ABA File Transfer Entry".FindSet THEN
                REPEAT
                    "AUZ ABA File Transfer Entry".Init;
                    "AUZ ABA File Transfer Entry"."Entry No." := "ABA File Transfer Entry"."Entry No.";
                    "AUZ ABA File Transfer Entry"."Type" := "ABA File Transfer Entry"."Type";
                    "AUZ ABA File Transfer Entry"."File Name" := "ABA File Transfer Entry"."File Name";
                    "AUZ ABA File Transfer Entry"."File Contents" := "ABA File Transfer Entry"."File Contents";
                    "AUZ ABA File Transfer Entry"."Created Date" := "ABA File Transfer Entry"."Created Date";
                    "AUZ ABA File Transfer Entry"."Created Time" := "ABA File Transfer Entry"."Created Time";
                    "AUZ ABA File Transfer Entry"."Handled Date" := "ABA File Transfer Entry"."Handled Date";
                    "AUZ ABA File Transfer Entry"."Handled" := "ABA File Transfer Entry"."Handled";
                    "AUZ ABA File Transfer Entry"."File Type Code" := "ABA File Transfer Entry"."File Type Code";
                    "AUZ ABA File Transfer Entry"."File Format Code" := "ABA File Transfer Entry"."File Format Code";
                    "AUZ ABA File Transfer Entry"."Forward by Email" := "ABA File Transfer Entry"."Forward by Email";
                    "AUZ ABA File Transfer Entry"."Task ID" := "ABA File Transfer Entry"."Task ID";
                    "AUZ ABA File Transfer Entry"."Transfer Status" := "ABA File Transfer Entry"."Transfer Status";
                    "AUZ ABA File Transfer Entry"."Handled by User ID" := "ABA File Transfer Entry"."Handled by User ID";
                    "AUZ ABA File Transfer Entry".Insert;
                UNTIL "ABA File Transfer Entry".next = 0;



            IF "ABA File Transfer Log".FindSet THEN
                REPEAT
                    "AUZ ABA File Transfer Log".Init;
                    "AUZ ABA File Transfer Log"."Entry No." := "ABA File Transfer Log"."Entry No.";
                    "AUZ ABA File Transfer Log"."Type" := "ABA File Transfer Log"."Type";
                    "AUZ ABA File Transfer Log"."File Name" := "ABA File Transfer Log"."File Name";
                    "AUZ ABA File Transfer Log"."No. of Files" := "ABA File Transfer Log"."No. of Files";
                    "AUZ ABA File Transfer Log"."Log Date" := "ABA File Transfer Log"."Log Date";
                    "AUZ ABA File Transfer Log"."Log Time" := "ABA File Transfer Log"."Log Time";
                    "AUZ ABA File Transfer Log"."Log Message" := "ABA File Transfer Log"."Log Message";
                    "AUZ ABA File Transfer Log"."FTP Setup Code" := "ABA File Transfer Log"."FTP Setup Code";
                    "AUZ ABA File Transfer Log"."Error" := "ABA File Transfer Log"."Error";
                    "AUZ ABA File Transfer Log"."Description" := "ABA File Transfer Log"."Description";
                    "AUZ ABA File Transfer Log"."Error Handled" := "ABA File Transfer Log"."Error Handled";
                    "AUZ ABA File Transfer Log"."File Transfer Entry No." := "ABA File Transfer Log"."File Transfer Entry No.";
                    "AUZ ABA File Transfer Log".Insert;
                UNTIL "ABA File Transfer Log".next = 0;



            IF "ABA File Type".FindSet THEN
                REPEAT
                    "AUZ ABA File Type".Init;
                    "AUZ ABA File Type"."Code" := "ABA File Type"."Code";
                    "AUZ ABA File Type"."Description" := "ABA File Type"."Description";
                    "AUZ ABA File Type".Insert;
                UNTIL "ABA File Type".next = 0;



            IF "ABA File Format".FindSet THEN
                REPEAT
                    "AUZ ABA File Format".Init;
                    "AUZ ABA File Format"."File Type Code" := "ABA File Format"."File Type Code";
                    "AUZ ABA File Format"."Code" := "ABA File Format"."Code";
                    "AUZ ABA File Format"."Description" := "ABA File Format"."Description";
                    "AUZ ABA File Format".Insert;
                UNTIL "ABA File Format".next = 0;


            IF "ABA FTP Setup".FindSet THEN
                REPEAT
                    "AUZ ABA FTP Setup".Init;
                    "AUZ ABA FTP Setup"."Code" := "ABA FTP Setup"."Code";
                    "AUZ ABA FTP Setup"."Description" := "ABA FTP Setup"."Description";
                    "AUZ ABA FTP Setup"."Address" := "ABA FTP Setup"."Address";
                    "AUZ ABA FTP Setup"."Enabled" := "ABA FTP Setup"."Enabled";
                    "AUZ ABA FTP Setup"."Service Provider" := "ABA FTP Setup"."Service Provider";
                    "AUZ ABA FTP Setup"."Terms of Service" := "ABA FTP Setup"."Terms of Service";
                    "AUZ ABA FTP Setup"."User Name" := "ABA FTP Setup"."User Name";
                    "AUZ ABA FTP Setup"."Password Key" := "ABA FTP Setup"."Password Key";
                    "AUZ ABA FTP Setup"."Type" := "ABA FTP Setup"."Type";
                    "AUZ ABA FTP Setup"."Host Key Fingerprint" := "ABA FTP Setup"."Host Key Fingerprint";
                    "AUZ ABA FTP Setup"."Private Key" := "ABA FTP Setup"."Private Key";
                    "AUZ ABA FTP Setup"."Port" := "ABA FTP Setup"."Port";
                    "AUZ ABA FTP Setup"."File Mask" := "ABA FTP Setup"."File Mask";
                    "AUZ ABA FTP Setup"."Export Path" := "ABA FTP Setup"."Export Path";
                    "AUZ ABA FTP Setup"."Import Path" := "ABA FTP Setup"."Import Path";
                    "AUZ ABA FTP Setup"."Azure Export Serv. Setup Code" := "ABA FTP Setup"."Azure Export Serv. Setup Code";
                    "AUZ ABA FTP Setup"."Azure Import Serv. Setup Code" := "ABA FTP Setup"."Azure Import Serv. Setup Code";
                    "AUZ ABA FTP Setup"."File Name Setup Code" := "ABA FTP Setup"."File Name Setup Code";
                    "AUZ ABA FTP Setup".Insert;
                UNTIL "ABA FTP Setup".next = 0;


            IF "ABA Azure Service Setup".FindSet THEN
                REPEAT
                    "AUZ ABA Azure Service Setup".Init;
                    "AUZ ABA Azure Service Setup"."Code" := "ABA Azure Service Setup"."Code";
                    "AUZ ABA Azure Service Setup"."Description" := "ABA Azure Service Setup"."Description";
                    "AUZ ABA Azure Service Setup"."Web Service URL" := "ABA Azure Service Setup"."Web Service URL";
                    "AUZ ABA Azure Service Setup"."Enabled" := "ABA Azure Service Setup"."Enabled";
                    "AUZ ABA Azure Service Setup"."Service Provider" := "ABA Azure Service Setup"."Service Provider";
                    "AUZ ABA Azure Service Setup"."Terms of Service" := "ABA Azure Service Setup"."Terms of Service";
                    "AUZ ABA Azure Service Setup".Insert;
                UNTIL "ABA Azure Service Setup".next = 0;


            IF "ABA File Name Setup Header".FindSet THEN
                REPEAT
                    "AUZ ABA File Name Setup Header".Init;
                    "AUZ ABA File Name Setup Header"."Code" := "ABA File Name Setup Header"."Code";
                    "AUZ ABA File Name Setup Header"."Description" := "ABA File Name Setup Header"."Description";
                    "AUZ ABA File Name Setup Header".Insert;
                UNTIL "ABA File Name Setup Header".next = 0;


            IF "ABA File Name Setup Line".FindSet THEN
                REPEAT
                    "AUZ ABA File Name Setup Line".Init;
                    "AUZ ABA File Name Setup Line"."File Name Setup Code" := "ABA File Name Setup Line"."File Name Setup Code";
                    "AUZ ABA File Name Setup Line"."Sequence" := "ABA File Name Setup Line"."Sequence";
                    "AUZ ABA File Name Setup Line"."Type" := "ABA File Name Setup Line"."Type";
                    "AUZ ABA File Name Setup Line"."Value" := "ABA File Name Setup Line"."Value";
                    "AUZ ABA File Name Setup Line"."No." := "ABA File Name Setup Line"."No.";
                    "AUZ ABA File Name Setup Line"."Description" := "ABA File Name Setup Line"."Description";
                    "AUZ ABA File Name Setup Line".Insert;
                UNTIL "ABA File Name Setup Line".next = 0;



            IF "Case Header".FindSet THEN
                REPEAT
                    "AUZ Case Header".Init;
                    "AUZ Case Header"."No." := "Case Header"."No.";
                    "AUZ Case Header"."Resource No." := "Case Header"."Resource No.";
                    "AUZ Case Header"."Contact No." := "Case Header"."Contact No.";
                    "AUZ Case Header"."Registered Date" := "Case Header"."Registered Date";
                    "AUZ Case Header"."Status" := "Case Header"."Status";
                    "AUZ Case Header"."Priority" := "Case Header"."Priority";
                    "AUZ Case Header"."Description" := "Case Header"."Description";
                    "AUZ Case Header"."Closed" := "Case Header"."Closed";
                    "AUZ Case Header"."Completed Date" := "Case Header"."Completed Date";
                    "AUZ Case Header"."No. Series" := "Case Header"."No. Series";
                    "AUZ Case Header"."Comment" := "Case Header"."Comment";
                    "AUZ Case Header"."Canceled" := "Case Header"."Canceled";
                    "AUZ Case Header"."Waiting for" := "Case Header"."Waiting for";
                    "AUZ Case Header"."Contact Company No." := "Case Header"."Contact Company No.";
                    "AUZ Case Header"."Consultant ID" := "Case Header"."Consultant ID";
                    "AUZ Case Header"."Developer ID" := "Case Header"."Developer ID";
                    "AUZ Case Header"."Consultant Comment" := "Case Header"."Consultant Comment";
                    "AUZ Case Header"."Developer Comment" := "Case Header"."Developer Comment";
                    "AUZ Case Header"."Information URL" := "Case Header"."Information URL";
                    "AUZ Case Header"."Update License" := "Case Header"."Update License";
                    "AUZ Case Header"."Last Date Modified" := "Case Header"."Last Date Modified";
                    "AUZ Case Header"."Last Time Modified" := "Case Header"."Last Time Modified";
                    "AUZ Case Header"."Reference No. Mandatory" := "Case Header"."Reference No. Mandatory";
                    "AUZ Case Header"."Completed By" := "Case Header"."Completed By";
                    "AUZ Case Header"."Ending Date" := "Case Header"."Ending Date";
                    "AUZ Case Header"."Job No." := "Case Header"."Job No.";
                    "AUZ Case Header"."Job Task No." := "Case Header"."Job Task No.";
                    "AUZ Case Header"."Registered By" := "Case Header"."Registered By";
                    "AUZ Case Header"."Desc. Change Request" := "Case Header"."Desc. Change Request";
                    "AUZ Case Header"."Desc. Solution" := "Case Header"."Desc. Solution";
                    "AUZ Case Header"."Work Type Code" := "Case Header"."Work Type Code";
                    "AUZ Case Header"."Estimate" := "Case Header"."Estimate";
                    "AUZ Case Header"."Agreed Estimate" := "Case Header"."Agreed Estimate";
                    "AUZ Case Header"."Promised Shipment Date" := "Case Header"."Promised Shipment Date";
                    "AUZ Case Header"."Resource Search Text" := "Case Header"."Resource Search Text";
                    "AUZ Case Header"."Datefilter" := "Case Header"."Datefilter";
                    "AUZ Case Header"."Development Approval Status" := "Case Header"."Development Approval Status";
                    "AUZ Case Header"."Development Status" := "Case Header"."Development Status";
                    "AUZ Case Header"."Standard Solution No." := "Case Header"."Standard Solution No.";
                    "AUZ Case Header".Insert;
                UNTIL "Case Header".next = 0;


            IF "Case E-Mail Template".FindSet THEN
                REPEAT
                    "AUZ Case E-Mail Template".Init;
                    "AUZ Case E-Mail Template"."Code" := "Case E-Mail Template"."Code";
                    "AUZ Case E-Mail Template"."Body" := "Case E-Mail Template"."Body";
                    "AUZ Case E-Mail Template"."Subject" := "Case E-Mail Template"."Subject";
                    "AUZ Case E-Mail Template"."Description in Subject" := "Case E-Mail Template"."Description in Subject";
                    "AUZ Case E-Mail Template"."Internal" := "Case E-Mail Template"."Internal";
                    "AUZ Case E-Mail Template"."To Development Admin." := "Case E-Mail Template"."To Development Admin.";
                    "AUZ Case E-Mail Template"."Company Name in Subject" := "Case E-Mail Template"."Company Name in Subject";
                    "AUZ Case E-Mail Template"."To Resources" := "Case E-Mail Template"."To Resources";
                    "AUZ Case E-Mail Template"."To Consultant" := "Case E-Mail Template"."To Consultant";
                    "AUZ Case E-Mail Template"."Description" := "Case E-Mail Template"."Description";
                    "AUZ Case E-Mail Template"."To Developer" := "Case E-Mail Template"."To Developer";
                    "AUZ Case E-Mail Template"."Use Default E-Mail" := "Case E-Mail Template"."Use Default E-Mail";
                    "AUZ Case E-Mail Template".Insert;
                UNTIL "Case E-Mail Template".next = 0;


            IF "Case Line".FindSet THEN
                REPEAT
                    "AUZ Case Line".Init;
                    "AUZ Case Line"."Case No." := "Case Line"."Case No.";
                    "AUZ Case Line"."Line No." := "Case Line"."Line No.";
                    "AUZ Case Line"."Resource No." := "Case Line"."Resource No.";
                    "AUZ Case Line"."Date" := "Case Line"."Date";
                    "AUZ Case Line"."Work Type" := "Case Line"."Work Type";
                    "AUZ Case Line"."Quantity" := "Case Line"."Quantity";
                    "AUZ Case Line"."Transferred" := "Case Line"."Transferred";
                    "AUZ Case Line"."Chargeable" := "Case Line"."Chargeable";
                    "AUZ Case Line"."Posted" := "Case Line"."Posted";
                    "AUZ Case Line"."Date/Time Modified" := "Case Line"."Date/Time Modified";
                    "AUZ Case Line"."Date/Time Created" := "Case Line"."Date/Time Created";
                    "AUZ Case Line"."Reference No." := "Case Line"."Reference No.";
                    "AUZ Case Line"."Job No." := "Case Line"."Job No.";
                    "AUZ Case Line"."Job Task No." := "Case Line"."Job Task No.";
                    "AUZ Case Line".Insert;
                UNTIL "Case Line".next = 0;


            IF "Case Object".FindSet THEN
                REPEAT
                    "AUZ Case Object".Init;
                    "AUZ Case Object"."Case No." := "Case Object"."Case No.";
                    "AUZ Case Object"."Line No." := "Case Object"."Line No.";
                    "AUZ Case Object"."Import Datetime" := "Case Object"."Import Datetime";
                    "AUZ Case Object"."Type" := "Case Object"."Type";
                    "AUZ Case Object"."ID" := "Case Object"."ID";
                    "AUZ Case Object"."Name" := "Case Object"."Name";
                    "AUZ Case Object"."Modified" := "Case Object"."Modified";
                    "AUZ Case Object"."Compiled" := "Case Object"."Compiled";
                    "AUZ Case Object"."Date" := "Case Object"."Date";
                    "AUZ Case Object"."Time" := "Case Object"."Time";
                    "AUZ Case Object"."Version List" := "Case Object"."Version List";
                    "AUZ Case Object"."Caption" := "Case Object"."Caption";
                    "AUZ Case Object"."Comment" := "Case Object"."Comment";
                    "AUZ Case Object".Insert;
                UNTIL "Case Object".next = 0;



            IF "Case Resource".FindSet THEN
                REPEAT
                    "AUZ Case Resource".Init;
                    "AUZ Case Resource"."Case No." := "Case Resource"."Case No.";
                    "AUZ Case Resource"."Resource No." := "Case Resource"."Resource No.";
                    "AUZ Case Resource".Insert;
                UNTIL "Case Resource".next = 0;



            IF "Expense Code".FindSet THEN
                REPEAT
                    "AUZ Expense Code".Init;
                    "AUZ Expense Code"."Code" := "Expense Code"."Code";
                    "AUZ Expense Code"."G/L Account No." := "Expense Code"."G/L Account No.";
                    "AUZ Expense Code"."Description" := "Expense Code"."Description";
                    "AUZ Expense Code"."Unit of Measure" := "Expense Code"."Unit of Measure";
                    "AUZ Expense Code"."Quantity" := "Expense Code"."Quantity";
                    "AUZ Expense Code"."Price" := "Expense Code"."Price";
                    "AUZ Expense Code".Insert;
                UNTIL "Expense Code".next = 0;



            IF "Case Hour Expense".FindSet THEN
                REPEAT
                    "AUZ Case Hour Expense".Init;
                    "AUZ Case Hour Expense"."Case No." := "Case Hour Expense"."Case No.";
                    "AUZ Case Hour Expense"."Case Hour Line No." := "Case Hour Expense"."Case Hour Line No.";
                    "AUZ Case Hour Expense"."Line No." := "Case Hour Expense"."Line No.";
                    "AUZ Case Hour Expense"."Expense Code" := "Case Hour Expense"."Expense Code";
                    "AUZ Case Hour Expense"."Description" := "Case Hour Expense"."Description";
                    "AUZ Case Hour Expense"."Unit of Measure" := "Case Hour Expense"."Unit of Measure";
                    "AUZ Case Hour Expense"."Quantity" := "Case Hour Expense"."Quantity";
                    "AUZ Case Hour Expense"."Price" := "Case Hour Expense"."Price";
                    "AUZ Case Hour Expense"."Transferred" := "Case Hour Expense"."Transferred";
                    "AUZ Case Hour Expense"."Posted" := "Case Hour Expense"."Posted";
                    "AUZ Case Hour Expense".Insert;
                UNTIL "Case Hour Expense".next = 0;



            IF "Job Expense".FindSet THEN
                REPEAT
                    "AUZ Job Expense".Init;
                    "AUZ Job Expense"."Job No." := "Job Expense"."Job No.";
                    "AUZ Job Expense"."Expense Code" := "Job Expense"."Expense Code";
                    "AUZ Job Expense"."Description" := "Job Expense"."Description";
                    "AUZ Job Expense"."Unit of Measure" := "Job Expense"."Unit of Measure";
                    "AUZ Job Expense"."Quantity" := "Job Expense"."Quantity";
                    "AUZ Job Expense"."Price" := "Job Expense"."Price";
                    "AUZ Job Expense".Insert;
                UNTIL "Job Expense".next = 0;



            IF "Case Cue".FindSet THEN
                REPEAT
                    "AUZ Case Cue".Init;
                    "AUZ Case Cue"."Primary Key" := "Case Cue"."Primary Key";
                    "AUZ Case Cue".Insert;
                UNTIL "Case Cue".next = 0;



            IF "Case Hour Description".FindSet THEN
                REPEAT
                    "AUZ Case Hour Description".Init;
                    "AUZ Case Hour Description"."Case No." := "Case Hour Description"."Case No.";
                    "AUZ Case Hour Description"."Case Hour Line No." := "Case Hour Description"."Case Hour Line No.";
                    "AUZ Case Hour Description"."Line No." := "Case Hour Description"."Line No.";
                    "AUZ Case Hour Description"."Description" := "Case Hour Description"."Description";
                    "AUZ Case Hour Description"."Transferred" := "Case Hour Description"."Transferred";
                    "AUZ Case Hour Description"."Posted" := "Case Hour Description"."Posted";
                    "AUZ Case Hour Description".Insert;
                UNTIL "Case Hour Description".next = 0;



            IF "Case Hour Chart Setup".FindSet THEN
                REPEAT
                    "AUZ Case Hour Chart Setup".Init;
                    "AUZ Case Hour Chart Setup"."User ID" := "Case Hour Chart Setup"."User ID";
                    "AUZ Case Hour Chart Setup"."Day" := "Case Hour Chart Setup"."Day";
                    "AUZ Case Hour Chart Setup"."Week" := "Case Hour Chart Setup"."Week";
                    "AUZ Case Hour Chart Setup"."Month" := "Case Hour Chart Setup"."Month";
                    "AUZ Case Hour Chart Setup"."Year" := "Case Hour Chart Setup"."Year";
                    "AUZ Case Hour Chart Setup"."Total" := "Case Hour Chart Setup"."Total";
                    "AUZ Case Hour Chart Setup"."Quarter" := "Case Hour Chart Setup"."Quarter";
                    "AUZ Case Hour Chart Setup"."Type" := "Case Hour Chart Setup"."Type";
                    "AUZ Case Hour Chart Setup"."Chargeable" := "Case Hour Chart Setup"."Chargeable";
                    "AUZ Case Hour Chart Setup"."Last Months Winner" := "Case Hour Chart Setup"."Last Months Winner";
                    "AUZ Case Hour Chart Setup"."Last Date Won" := "Case Hour Chart Setup"."Last Date Won";
                    "AUZ Case Hour Chart Setup"."Last Quantity Won" := "Case Hour Chart Setup"."Last Quantity Won";
                    "AUZ Case Hour Chart Setup"."Show in Chart" := "Case Hour Chart Setup"."Show in Chart";
                    "AUZ Case Hour Chart Setup".Insert;
                UNTIL "Case Hour Chart Setup".next = 0;



            IF "Case Setup".FindSet THEN
                REPEAT
                    "AUZ Case Setup".Init;
                    "AUZ Case Setup"."Primary Key" := "Case Setup"."Primary Key";
                    "AUZ Case Setup"."Default Work Type" := "Case Setup"."Default Work Type";
                    "AUZ Case Setup"."Default E-Mail" := "Case Setup"."Default E-Mail";
                    "AUZ Case Setup".Insert;
                UNTIL "Case Setup".next = 0;



            IF "Related Case".FindSet THEN
                REPEAT
                    "AUZ Related Case".Init;
                    "AUZ Related Case"."Case No." := "Related Case"."Case No.";
                    "AUZ Related Case"."Related Case No." := "Related Case"."Related Case No.";
                    "AUZ Related Case"."Description" := "Related Case"."Description";
                    "AUZ Related Case".Insert;
                UNTIL "Related Case".next = 0;



            IF "Case Standard Solultion".FindSet THEN
                REPEAT
                    "AUZ Case Standard Solultion".Init;
                    "AUZ Case Standard Solultion"."Case No." := "Case Standard Solultion"."Case No.";
                    "AUZ Case Standard Solultion"."Standard Solution No." := "Case Standard Solultion"."Standard Solution No.";
                    "AUZ Case Standard Solultion".Insert;
                UNTIL "Case Standard Solultion".next = 0;



            IF "Case Journal Line".FindSet THEN
                REPEAT
                    "AUZ Case Journal Line".Init;
                    "AUZ Case Journal Line"."Resource No." := "Case Journal Line"."Resource No.";
                    "AUZ Case Journal Line"."Line No." := "Case Journal Line"."Line No.";
                    "AUZ Case Journal Line"."Case No." := "Case Journal Line"."Case No.";
                    "AUZ Case Journal Line"."Date" := "Case Journal Line"."Date";
                    "AUZ Case Journal Line"."Imported" := "Case Journal Line"."Imported";
                    "AUZ Case Journal Line"."Work Type" := "Case Journal Line"."Work Type";
                    "AUZ Case Journal Line"."Quantity" := "Case Journal Line"."Quantity";
                    "AUZ Case Journal Line"."Work Description" := "Case Journal Line"."Work Description";
                    "AUZ Case Journal Line"."Modified Object Text" := "Case Journal Line"."Modified Object Text";
                    "AUZ Case Journal Line"."Add Descriptions to Solution" := "Case Journal Line"."Add Descriptions to Solution";
                    "AUZ Case Journal Line"."Chargeable" := "Case Journal Line"."Chargeable";
                    "AUZ Case Journal Line"."Reference No." := "Case Journal Line"."Reference No.";
                    "AUZ Case Journal Line".Insert;
                UNTIL "Case Journal Line".next = 0;



            IF "Case Journal Line Description".FindSet THEN
                REPEAT
                    "AUZ Case Journal Line Description".Init;
                    "AUZ Case Journal Line Description"."Resource No." := "Case Journal Line Description"."Resource No.";
                    "AUZ Case Journal Line Description"."Journal Line No." := "Case Journal Line Description"."Journal Line No.";
                    "AUZ Case Journal Line Description"."Line No." := "Case Journal Line Description"."Line No.";
                    "AUZ Case Journal Line Description"."Description" := "Case Journal Line Description"."Description";
                    "AUZ Case Journal Line Description".Insert;
                UNTIL "Case Journal Line Description".next = 0;



            IF "Standard Solution Setup".FindSet THEN
                REPEAT
                    "AUZ Standard Solution Setup".Init;
                    "AUZ Standard Solution Setup"."Primary Key" := "Standard Solution Setup"."Primary Key";
                    "AUZ Standard Solution Setup"."Standard Solution Nos." := "Standard Solution Setup"."Standard Solution Nos.";
                    "AUZ Standard Solution Setup".Insert;
                UNTIL "Standard Solution Setup".next = 0;



            IF "Standard Solution Release".FindSet THEN
                REPEAT
                    "AUZ Standard Solution Release".Init;
                    "AUZ Standard Solution Release"."Standard Solution No." := "Standard Solution Release"."Standard Solution No.";
                    "AUZ Standard Solution Release"."Version Code" := "Standard Solution Release"."Version Code";
                    "AUZ Standard Solution Release"."Date Created" := "Standard Solution Release"."Date Created";
                    "AUZ Standard Solution Release"."Date Modified" := "Standard Solution Release"."Date Modified";
                    "AUZ Standard Solution Release"."Previous Version Code" := "Standard Solution Release"."Previous Version Code";
                    "AUZ Standard Solution Release".Insert;
                UNTIL "Standard Solution Release".next = 0;



            IF "Standard Solution Contact".FindSet THEN
                REPEAT
                    "AUZ Standard Solution Contact".Init;
                    "AUZ Standard Solution Contact"."Standard Solution No." := "Standard Solution Contact"."Standard Solution No.";
                    "AUZ Standard Solution Contact"."Contact No." := "Standard Solution Contact"."Contact No.";
                    "AUZ Standard Solution Contact"."Version Code" := "Standard Solution Contact"."Version Code";
                    "AUZ Standard Solution Contact".Insert;
                UNTIL "Standard Solution Contact".next = 0;



            IF "Standard Solution Object".FindSet THEN
                REPEAT
                    "AUZ Standard Solution Object".Init;
                    "AUZ Standard Solution Object"."Standard Solution No." := "Standard Solution Object"."Standard Solution No.";
                    "AUZ Standard Solution Object"."Line No." := "Standard Solution Object"."Line No.";
                    "AUZ Standard Solution Object"."Import Datetime" := "Standard Solution Object"."Import Datetime";
                    "AUZ Standard Solution Object"."Type" := "Standard Solution Object"."Type";
                    "AUZ Standard Solution Object"."ID" := "Standard Solution Object"."ID";
                    "AUZ Standard Solution Object"."Name" := "Standard Solution Object"."Name";
                    "AUZ Standard Solution Object"."Modified" := "Standard Solution Object"."Modified";
                    "AUZ Standard Solution Object"."Compiled" := "Standard Solution Object"."Compiled";
                    "AUZ Standard Solution Object"."Date" := "Standard Solution Object"."Date";
                    "AUZ Standard Solution Object"."Time" := "Standard Solution Object"."Time";
                    "AUZ Standard Solution Object"."Version List" := "Standard Solution Object"."Version List";
                    "AUZ Standard Solution Object"."Caption" := "Standard Solution Object"."Caption";
                    "AUZ Standard Solution Object"."Version Code" := "Standard Solution Object"."Version Code";
                    "AUZ Standard Solution Object"."Comment" := "Standard Solution Object"."Comment";
                    "AUZ Standard Solution Object".Insert;
                UNTIL "Standard Solution Object".next = 0;



            IF "Standard Solution Change".FindSet THEN
                REPEAT
                    "AUZ Standard Solution Change".Init;
                    "AUZ Standard Solution Change"."Standard Solution No." := "Standard Solution Change"."Standard Solution No.";
                    "AUZ Standard Solution Change"."Line No." := "Standard Solution Change"."Line No.";
                    "AUZ Standard Solution Change"."Description" := "Standard Solution Change"."Description";
                    "AUZ Standard Solution Change"."Version Code" := "Standard Solution Change"."Version Code";
                    "AUZ Standard Solution Change".Insert;
                UNTIL "Standard Solution Change".next = 0;



            IF "Standard Solution".FindSet THEN
                REPEAT
                    "AUZ Standard Solution".Init;
                    "AUZ Standard Solution"."No." := "Standard Solution"."No.";
                    "AUZ Standard Solution"."Name" := "Standard Solution"."Name";
                    "AUZ Standard Solution"."Date Created" := "Standard Solution"."Date Created";
                    "AUZ Standard Solution"."Date Modified" := "Standard Solution"."Date Modified";
                    "AUZ Standard Solution"."Description" := "Standard Solution"."Description";
                    "AUZ Standard Solution"."Version Tag" := "Standard Solution"."Version Tag";
                    "AUZ Standard Solution"."Solution No." := "Standard Solution"."Solution No.";
                    "AUZ Standard Solution"."3. Part Integration" := "Standard Solution"."3. Part Integration";
                    "AUZ Standard Solution"."Responsible Resource No." := "Standard Solution"."Responsible Resource No.";
                    "AUZ Standard Solution"."Start ID" := "Standard Solution"."Start ID";
                    "AUZ Standard Solution"."End ID" := "Standard Solution"."End ID";
                    "AUZ Standard Solution"."Type" := "Standard Solution"."Type";
                    "AUZ Standard Solution"."Extended Description" := "Standard Solution"."Extended Description";
                    "AUZ Standard Solution"."Importance" := "Standard Solution"."Importance";
                    "AUZ Standard Solution"."Object Type" := "Standard Solution"."Object Type";
                    "AUZ Standard Solution"."Indentation" := "Standard Solution"."Indentation";
                    "AUZ Standard Solution"."AppSource Prefix / Suffix" := "Standard Solution"."AppSource Prefix / Suffix";
                    "AUZ Standard Solution"."Prefix / Suffix" := "Standard Solution"."Prefix / Suffix";
                    "AUZ Standard Solution"."AppSource Start ID" := "Standard Solution"."AppSource Start ID";
                    "AUZ Standard Solution"."AppSource End ID" := "Standard Solution"."AppSource End ID";
                    "AUZ Standard Solution"."Obsolete State" := "Standard Solution"."Obsolete State";
                    "AUZ Standard Solution"."Obsolete Reason" := "Standard Solution"."Obsolete Reason";
                    "AUZ Standard Solution".Insert;
                UNTIL "Standard Solution".next = 0;



            IF "Standard Solution To-do".FindSet THEN
                REPEAT
                    "AUZ Standard Solution To-do".Init;
                    "AUZ Standard Solution To-do"."Standard Solution No." := "Standard Solution To-do"."Standard Solution No.";
                    "AUZ Standard Solution To-do"."Line No." := "Standard Solution To-do"."Line No.";
                    "AUZ Standard Solution To-do"."Description" := "Standard Solution To-do"."Description";
                    "AUZ Standard Solution To-do"."Description 2" := "Standard Solution To-do"."Description 2";
                    "AUZ Standard Solution To-do"."Completed" := "Standard Solution To-do"."Completed";
                    "AUZ Standard Solution To-do"."Version Code" := "Standard Solution To-do"."Version Code";
                    "AUZ Standard Solution To-do"."Case No." := "Standard Solution To-do"."Case No.";
                    "AUZ Standard Solution To-do".Insert;
                UNTIL "Standard Solution To-do".next = 0;



            IF "Standard Solution Field".FindSet THEN
                REPEAT
                    "AUZ Standard Solution Field".Init;
                    "AUZ Standard Solution Field"."Standard Solution No." := "Standard Solution Field"."Standard Solution No.";
                    "AUZ Standard Solution Field"."Line No." := "Standard Solution Field"."Line No.";
                    "AUZ Standard Solution Field"."Description" := "Standard Solution Field"."Description";
                    "AUZ Standard Solution Field"."Table No." := "Standard Solution Field"."Table No.";
                    "AUZ Standard Solution Field"."Table Name" := "Standard Solution Field"."Table Name";
                    "AUZ Standard Solution Field"."Field No." := "Standard Solution Field"."Field No.";
                    "AUZ Standard Solution Field"."Field Name" := "Standard Solution Field"."Field Name";
                    "AUZ Standard Solution Field".Insert;
                UNTIL "Standard Solution Field".next = 0;



            IF "Remote Setup".FindSet THEN
                REPEAT
                    "AUZ Remote Setup".Init;
                    "AUZ Remote Setup"."Primary Key" := "Remote Setup"."Primary Key";
                    "AUZ Remote Setup"."Remote Login Nos." := "Remote Setup"."Remote Login Nos.";
                    "AUZ Remote Setup".Insert;
                UNTIL "Remote Setup".next = 0;



            IF "Remote Access".FindSet THEN
                REPEAT
                    "AUZ Remote Access".Init;
                    "AUZ Remote Access"."No." := "Remote Access"."No.";
                    "AUZ Remote Access"."Description" := "Remote Access"."Description";
                    "AUZ Remote Access"."No. Series" := "Remote Access"."No. Series";
                    "AUZ Remote Access".Insert;
                UNTIL "Remote Access".next = 0;



            IF "Remote User".FindSet THEN
                REPEAT
                    "AUZ Remote User".Init;
                    "AUZ Remote User"."Remote Access No." := "Remote User"."Remote Access No.";
                    "AUZ Remote User"."Type" := "Remote User"."Type";
                    "AUZ Remote User"."Line No." := "Remote User"."Line No.";
                    "AUZ Remote User"."Domain" := "Remote User"."Domain";
                    "AUZ Remote User"."Username" := "Remote User"."Username";
                    "AUZ Remote User"."Password" := "Remote User"."Password";
                    "AUZ Remote User"."Description" := "Remote User"."Description";
                    "AUZ Remote User".Insert;
                UNTIL "Remote User".next = 0;



            IF "Remote Login".FindSet THEN
                REPEAT
                    "AUZ Remote Login".Init;
                    "AUZ Remote Login"."Remote Access No." := "Remote Login"."Remote Access No.";
                    "AUZ Remote Login"."Type" := "Remote Login"."Type";
                    "AUZ Remote Login"."Line No." := "Remote Login"."Line No.";
                    "AUZ Remote Login"."Comuter Type" := "Remote Login"."Comuter Type";
                    "AUZ Remote Login"."Domain" := "Remote Login"."Domain";
                    "AUZ Remote Login"."Name" := "Remote Login"."Name";
                    "AUZ Remote Login"."Login Type" := "Remote Login"."Login Type";
                    "AUZ Remote Login"."Login ID" := "Remote Login"."Login ID";
                    "AUZ Remote Login"."Description" := "Remote Login"."Description";
                    "AUZ Remote Login".Insert;
                UNTIL "Remote Login".next = 0;



            IF "Computer Type".FindSet THEN
                REPEAT
                    "AUZ Computer Type".Init;
                    "AUZ Computer Type"."Code" := "Computer Type"."Code";
                    "AUZ Computer Type"."Description" := "Computer Type"."Description";
                    "AUZ Computer Type".Insert;
                UNTIL "Computer Type".next = 0;



            IF "Login Type".FindSet THEN
                REPEAT
                    "AUZ Login Type".Init;
                    "AUZ Login Type"."Code" := "Login Type"."Code";
                    "AUZ Login Type"."Description" := "Login Type"."Description";
                    "AUZ Login Type".Insert;
                UNTIL "Login Type".next = 0;



            IF "Login Path".FindSet THEN
                REPEAT
                    "AUZ Login Path".Init;
                    "AUZ Login Path"."Login Type" := "Login Path"."Login Type";
                    "AUZ Login Path"."Sequence" := "Login Path"."Sequence";
                    "AUZ Login Path"."Description" := "Login Path"."Description";
                    "AUZ Login Path"."Path" := "Login Path"."Path";
                    "AUZ Login Path"."Parameters" := "Login Path"."Parameters";
                    "AUZ Login Path".Insert;
                UNTIL "Login Path".next = 0;



            IF "Login Paramenter".FindSet THEN
                REPEAT
                    "AUZ Login Paramenter".Init;
                    "AUZ Login Paramenter"."Login Type" := "Login Paramenter"."Login Type";
                    "AUZ Login Paramenter"."Sequence" := "Login Paramenter"."Sequence";
                    "AUZ Login Paramenter"."Replace" := "Login Paramenter"."Replace";
                    "AUZ Login Paramenter"."Description" := "Login Paramenter"."Description";
                    "AUZ Login Paramenter"."Value Type" := "Login Paramenter"."Value Type";
                    "AUZ Login Paramenter".Insert;
                UNTIL "Login Paramenter".next = 0;

        end;
     */


    var
        "Service Copy Setup": Record "AUZ Service Copy Setup";
        "AUZ Service Copy Setup": Record "AUZ Service Copy Setup";
        "ABA File Transfer Setup": Record "ABA File Transfer Setup";
        "AUZ ABA File Transfer Setup": Record "AUZ ABA File Transfer Setup";
        "ABA File Transfer Entry": Record "ABA File Transfer Entry";
        "AUZ ABA File Transfer Entry": Record "AUZ ABA File Transfer Entry";
        "ABA File Transfer Log": Record "ABA File Transfer Log";
        "AUZ ABA File Transfer Log": Record "AUZ ABA File Transfer Log";
        "ABA File Type": Record "ABA File Type";
        "AUZ ABA File Type": Record "AUZ ABA File Type";
        "ABA File Format": Record "ABA File Format";
        "AUZ ABA File Format": Record "AUZ ABA File Format";
        "ABA FTP Setup": Record "ABA FTP Setup";
        "AUZ ABA FTP Setup": Record "AUZ ABA FTP Setup";
        "ABA Azure Service Setup": Record "ABA Azure Service Setup";
        "AUZ ABA Azure Service Setup": Record "AUZ ABA Azure Service Setup";
        "ABA File Name Setup Header": Record "ABA File Name Setup Header";
        "AUZ ABA File Name Setup Header": Record "AUZ ABA File Name Setup Header";
        "ABA File Name Setup Line": Record "ABA File Name Setup Line";
        "AUZ ABA File Name Setup Line": Record "AUZ ABA File Name Setup Line";
        "Case Header": Record "Case Header";
        "AUZ Case Header": Record "AUZ Case Header";
        "Case E-Mail Template": Record "Case E-Mail Template";
        "AUZ Case E-Mail Template": Record "AUZ Case E-Mail Template";
        "Case Line": Record "Case Line";
        "AUZ Case Line": Record "AUZ Case Line";
        "Case Object": Record "Case Object";
        "AUZ Case Object": Record "AUZ Case Object";
        "Case Resource": Record "Case Resource";
        "AUZ Case Resource": Record "AUZ Case Resource";
        "Expense Code": Record "Expense Code";
        "AUZ Expense Code": Record "AUZ Expense Code";
        "Case Hour Expense": Record "Case Hour Expense";
        "AUZ Case Hour Expense": Record "AUZ Case Line Expense";
        "Job Expense": Record "Job Expense";
        "AUZ Job Expense": Record "AUZ Job Expense";
        "Case Cue": Record "Case Cue";
        "AUZ Case Cue": Record "AUZ Case Cue";
        "Case Hour Description": Record "Case Hour Description";
        "AUZ Case Hour Description": Record "AUZ Case Line Description";
        "Case Hour Chart Setup": Record "Case Hour Chart Setup";
        "AUZ Case Hour Chart Setup": Record "AUZ Case Line Chart Setup";
        "Case Setup": Record "Case Setup";
        "AUZ Case Setup": Record "AUZ Case Setup";
        "Related Case": Record "Related Case";
        "AUZ Related Case": Record "AUZ Related Case";
        "Case Standard Solultion": Record "Case Standard Solultion";
        "AUZ Case Standard Solultion": Record "AUZ Case Standard Solultion";
        "Case Journal Line": Record "Case Journal Line";
        "AUZ Case Journal Line": Record "AUZ Case Journal Line";
        "Case Journal Line Description": Record "Case Journal Line Description";
        "AUZ Case Journal Line Description": Record "AUZ Case Journal Line Desc.";
        "Standard Solution Setup": Record "Standard Solution Setup";
        "AUZ Standard Solution Setup": Record "AUZ Standard Solution Setup";
        "Standard Solution Release": Record "Standard Solution Release";
        "AUZ Standard Solution Release": Record "AUZ Standard Solution Release";
        "Standard Solution Contact": Record "Standard Solution Contact";
        "AUZ Standard Solution Contact": Record "AUZ Standard Solution Contact";
        "Standard Solution Object": Record "Standard Solution Object";
        "AUZ Standard Solution Object": Record "AUZ Standard Solution Object";
        "Standard Solution Change": Record "Standard Solution Change";
        "AUZ Standard Solution Change": Record "AUZ Standard Solution Change";
        "Standard Solution": Record "Standard Solution";
        "AUZ Standard Solution": Record "AUZ Standard Solution";
        "Standard Solution To-do": Record "Standard Solution To-do";
        "AUZ Standard Solution To-do": Record "AUZ Standard Solution To-do";
        "Standard Solution Field": Record "Standard Solution Field";
        "AUZ Standard Solution Field": Record "AUZ Standard Solution Field";
        "Remote Setup": Record "Remote Setup";
        "AUZ Remote Setup": Record "AUZ Remote Setup";
        "Remote Access": Record "Remote Access";
        "AUZ Remote Access": Record "AUZ Remote Access";
        "Remote User": Record "Remote User";
        "AUZ Remote User": Record "AUZ Remote User";
        "Remote Login": Record "Remote Login";
        "AUZ Remote Login": Record "AUZ Remote Login";
        "Computer Type": Record "Computer Type";
        "AUZ Computer Type": Record "AUZ Computer Type";
        "Login Type": Record "Login Type";
        "AUZ Login Type": Record "AUZ Login Type";
        "Login Path": Record "Login Path";
        "AUZ Login Path": Record "AUZ Login Path";
        "Login Paramenter": Record "Login Paramenter";
        "AUZ Login Paramenter": Record "AUZ Login Paramenter";
        "AZ Setup": Record "AZ Setup";
        "AUZ AZ Setup": Record "AUZ AZ Setup";
        "Customer Resp. Hours Approver": Record "Customer Resp. Hours Approver";
        "AUZ Customer Resp. Hours Approver": Record "AUZ Cust. Resp. Hours Approver";
        "Invoicing Period": Record "Invoicing Period";
        "AUZ Invoicing Period": Record "AUZ Invoicing Period";
        "Tables To Clean": Record "Tables To Clean";
        "AUZ Tables To Clean": Record "AUZ Tables To Clean";
        "Sales Chart Setup": Record "Sales Chart Setup";
        "AUZ Sales Chart Setup": Record "AUZ Sales Chart Setup";
        "Object Compare": Record "Object Compare";
        "AUZ Object Compare": Record "AUZ Object Compare";
        "Object Compared": Record "Object Compared";
        "AUZ Object Compared": Record "AUZ Object Compared";
        "Accounting Setup": Record "Accounting Setup";
        "AUZ Accounting Setup": Record "AUZ Accounting Setup";
        "External File Management Setup": Record "External File Management Setup";
        "AUZ External File Management Setup": Record "AUZ External File Management Setup";
        "External File": Record "External File";
        "AUZ External File": Record "AUZ External File";
        "Distribution Setup": Record "Distribution Setup";
        "AUZ Distribution Setup": Record "AUZ Distribution Setup";
        "Distribution Log Entry": Record "Distribution Log Entry";
        "AUZ Distribution Log Entry": Record "AUZ Distribution Log Entry";

}