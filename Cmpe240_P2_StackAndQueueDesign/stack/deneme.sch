VERSION 5
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "Spartan2"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    End ATTR
    BEGIN NETLIST
        BEGIN BLOCKDEF 6bitdflipflop
            TIMESTAMP 2005 6 5 20 6 42
            LINE N 0 -128 64 -128 
            LINE N 0 -192 64 -192 
            LINE N 0 -32 64 -32 
            LINE N 0 -256 64 -256 
            LINE N 384 -256 320 -256 
            LINE N 192 -32 64 -32 
            LINE N 192 -64 192 -32 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
            RECTANGLE N 320 -268 384 -244 
            RECTANGLE N 0 -268 64 -244 
            RECTANGLE N 64 -320 320 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF m2_1e
            TIMESTAMP 2001 2 2 12 54 40
            LINE N 0 -96 96 -96 
            LINE N 0 -32 96 -32 
            LINE N 208 -32 92 -32 
            LINE N 208 -152 208 -32 
            LINE N 144 -96 96 -96 
            LINE N 144 -136 144 -96 
            LINE N 96 -128 96 -256 
            LINE N 256 -160 96 -128 
            LINE N 256 -224 256 -160 
            LINE N 96 -256 256 -224 
            LINE N 320 -192 256 -192 
            LINE N 0 -224 96 -224 
            LINE N 0 -160 96 -160 
        END BLOCKDEF
        BEGIN BLOCK XLXI_6 6bitdflipflop
            PIN C
            PIN CE
            PIN CLR
            PIN D(5:0)
            PIN Q(5:0)
        END BLOCK
        BEGIN BLOCK XLXI_7 6bitdflipflop
            PIN C
            PIN CE
            PIN CLR
            PIN D(5:0)
            PIN Q(5:0)
        END BLOCK
        BEGIN BLOCK XLXI_8 6bitdflipflop
            PIN C
            PIN CE
            PIN CLR
            PIN D(5:0)
            PIN Q(5:0)
        END BLOCK
        BEGIN BLOCK XLXI_9 6bitdflipflop
            PIN C
            PIN CE
            PIN CLR
            PIN D(5:0)
            PIN Q(5:0)
        END BLOCK
        BEGIN BLOCK XLXI_14 m2_1e
            PIN D0
            PIN D1
            PIN E
            PIN S0
            PIN O
        END BLOCK
        BEGIN BLOCK XLXI_15 m2_1e
            PIN D0
            PIN D1
            PIN E
            PIN S0
            PIN O
        END BLOCK
        BEGIN BLOCK XLXI_16 m2_1e
            PIN D0
            PIN D1
            PIN E
            PIN S0
            PIN O
        END BLOCK
        BEGIN BLOCK XLXI_17 m2_1e
            PIN D0
            PIN D1
            PIN E
            PIN S0
            PIN O
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE XLXI_7 1232 1008 R0
        INSTANCE XLXI_8 1872 1040 R0
        INSTANCE XLXI_9 2528 992 R0
        INSTANCE XLXI_14 544 256 R90
        INSTANCE XLXI_15 1248 272 R90
        INSTANCE XLXI_16 1888 288 R90
        INSTANCE XLXI_17 2576 272 R90
        INSTANCE XLXI_6 544 1040 R0
    END SHEET
END SCHEMATIC
