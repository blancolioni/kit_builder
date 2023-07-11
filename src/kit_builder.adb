with Ada.Command_Line;
with Ada.Text_IO;

with Kit.Command_Line;
with Kit.Driver;

procedure Kit_Builder is
begin
   Ada.Text_IO.Put_Line (Ada.Command_Line.Command_Name);
   if Kit.Command_Line.Parse_Command_Line then
      if Kit.Command_Line.Main_File = "" then
         Ada.Text_IO.Put_Line
           (Ada.Text_IO.Standard_Error,
            "Missing database specification file");
         Ada.Command_Line.Set_Exit_Status (2);
         return;
      end if;

      Kit.Driver.Execute
        (Path => Kit.Command_Line.Main_File,
         Ada_2022 => Kit.Command_Line.Ada_2022);

   else
      Ada.Command_Line.Set_Exit_Status (1);
   end if;
end Kit_Builder;
