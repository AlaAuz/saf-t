//ALA
//FIX

/*
pageextension 50050 "AUZ Purch. Invoice With Image" extends "CDC Purch. Invoice With Image"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field(KID; KID)
            {
                Visible = false;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the Kunde ID (KID) associated with purchase header.';
            }
            field("Posting Description"; "Posting Description")
            {
                Visible = false;
            }
            field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
            {
                Visible = false;
                ApplicationArea = Dimensions;
                ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                trigger OnValidate()
                begin
                    ShortcutDimension1CodeOnAfterV;
                end;
            }
            field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
            {
                Visible = false;
                ApplicationArea = Dimensions;
                ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                trigger OnValidate()
                begin
                    ShortcutDimension2CodeOnAfterV;
                end;
            }
        }
    }
    actions
    {
        addafter("Payment Information")
        {
            action(CreateSalesOrder)
            {
                Caption = 'Create Sales Order';
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CreateSalesOrder;
                end;
            }
        }
    }
} */