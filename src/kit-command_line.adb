with Ada.Text_IO;

with Parse_Args;

package body Kit.Command_Line is

   AP : Parse_Args.Argument_Parser;

   --------------
   -- Ada_2022 --
   --------------

   function Ada_2022 return Boolean is
   begin
      return AP.Boolean_Value ("ada-2022");
   end Ada_2022;

   ---------------
   -- Main_File --
   ---------------

   function Main_File return String is
   begin
      return AP.String_Value ("main-kit-file");
   end Main_File;

   ----------------------
   -- Output_Directory --
   ----------------------

   function Output_Directory return String is
   begin
      return AP.String_Value ("output-directory");
   end Output_Directory;

   ------------------------
   -- Parse_Command_Line --
   ------------------------

   function Parse_Command_Line return Boolean is
      use Parse_Args;
   begin
      AP.Add_Option (Make_Boolean_Option (False), "ada-2022",
                     Long_Option => "ada-2022",
                     Usage => "Generate Ada 2022 source");
      AP.Add_Option (Make_String_Option ("."), "output-directory",
                     Short_Option => 'd',
                     Long_Option => "output-directory",
                     Usage => "directory for generated files");
      AP.Append_Positional (Make_String_Option, "main-kit-file");
      AP.Set_Prologue ("Kit database specification compiler");

      AP.Parse_Command_Line;

      if not AP.Parse_Success then
         Ada.Text_IO.Put_Line
           (Ada.Text_IO.Standard_Error,
            AP.Parse_Message);
      end if;

      return AP.Parse_Success;

   end Parse_Command_Line;

end Kit.Command_Line;
