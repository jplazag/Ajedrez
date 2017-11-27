void save(ArrayList hoja) {

  output = createWriter("match.txt"); 
  for (int x = 0; x < hoja.size(); x++)
    output.println(hoja.get(x)); // Write 
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
}