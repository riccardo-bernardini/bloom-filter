generic
   type Key_Type is private;
package Bloom_Filters is
   type Bloom_Filter (<>) is private;

   function Create (Table_Size : Positive;
                    N_Hashes   : Positive)
                    return Bloom_Filter
     with
       Pre => Table_Size >= 2;

   type Fill_Ratio is digits 16 range 0.0 .. 1.0;
   type Probability is digits 16 range 0.0 .. 1.0;

   function Create (Expected_Fill       : Fill_Ratio;
                    False_Positive_Prob : Probability)
                    return Bloom_Filter;

   procedure Add (Filter : in out Bloom_Filter;
                  Item   : Key_Type);

   function Contains (Filter : Bloom_Filter;
                      Item   : Key_Type)
                      return Boolean;
private
   type Map_Index is range 1 .. 2 ** 32;
   type Hash_Type is range 0 .. 2 ** 32 - 1;

   type Bool_Matrix is
     array (Map_Index range <>, Hash_Type range <>) of Boolean;

   type Bloom_Filter (N_Hashes : Map_Index;
                      Max_Hash : Hash_Type)
   is
      record
         Maps         : Bool_Matrix (1 .. N_Hashes, 0 .. Max_Hash);
         Bit_Per_Hash : Positive;
      end record;

end Bloom_Filters;