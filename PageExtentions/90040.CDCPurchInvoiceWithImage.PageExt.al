pageextension 90040 "AUZ Purch. Invoice With Image" extends "CDC Purch. Invoice With Image"
{
    layout
    {
        modify("Posting Description")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(KID)
        {
            Visible = false;
        }
        addafter("Vendor Invoice No.")
        {
            field(KID; KID)
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the Kunde ID (KID) associated with purchase header.';
            }
            field("Posting Description"; "Posting Description")
            {
            }
            field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
            {
                ApplicationArea = Dimensions;
                ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                trigger OnValidate()
                begin
                    ShortcutDimension1CodeOnAfterV;
                end;
            }
            field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
            {
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
}

