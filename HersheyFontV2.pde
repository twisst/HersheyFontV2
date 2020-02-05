
// based on https://github.com/ixd-hof/HersheyFont/

String hershey_font[];
int hheight = 21;
float hfactor = 1;



void setup()
{
  size(925, 500, P3D);
  // Available fonts included:
  // astrology.jhf, cursive.jhf, cyrilc_1.jhf, cyrillic.jhf, futural.jhf, futuram.jhf, gothgbt.jhf, gothgrt.jhf, gothiceng.jhf, gothicger.jhf, gothicita.jhf, gothitt.jhf, greek.jhf, greekc.jhf, greeks.jhf, hershey.txt, hershey.zip, japanese.jhf, markers.jhf, mathlow.jhf, mathupp.jhf, meteorology.jhf, music.jhf, rowmand.jhf, rowmans.jhf, rowmant.jhf, scriptc.jhf, scripts.jhf, symbolic.jhf, tex-hershey.zip, timesg.jhf, timesi.jhf, timesib.jhf, timesr.jhf, timesrb.jhf
   HersheyFont("/Users/jaap/Downloads/hershey_font_converter-master/hershey-fonts/scriptc.jhf");
  textSize(100);
}

void draw()
{
  background(255);
  
  translate(100, height/3);
  text("hello", 0, 0);
  translate(0, height/3);
  shape(getShape("processing"));
}



void HersheyFont(String fontfile) {

  String [] hershey_font_org;

  //if (fontfile.indexOf(".jhf") != -1)
  hershey_font_org = loadStrings(fontfile);

  String hershey_font_string = "";

  for (int i=0; i<hershey_font_org.length; i++)
  {
    String line = hershey_font_org[i].trim();
    if (line.charAt(0) >= 48 && line.charAt(0) <= 57)
      hershey_font_string += line + "\n";
    else
    {
      hershey_font_string = hershey_font_string.substring(0, hershey_font_string.length()-1) + line + "\n";
    }
  }
  hershey_font = hershey_font_string.split("\n");
}

public void textSize(float size)
{
  hfactor = size/hheight;
}

public PShape getShape(String s)
{
  int swidth = 0;
  for (int i=0; i<s.length (); i++)
  {
    swidth += get_character_width(s.charAt(i));
  }

  float pos_x = 0;
  PShape sh = createShape(GROUP);

  for (int ss=0; ss<s.length (); ss++)
  {
    PShape shc = createShape();
    char c = s.charAt(ss);
    String h = hershey_font[c - 32 ];

    int start_col = h.indexOf(" ");

    int vertices_length = Integer.parseInt(h.substring(start_col+1, start_col+3).trim());

    int h_left = hershey2coord(h.charAt(start_col+3));
    int h_right = hershey2coord(h.charAt(start_col+4));
    float h_width = h_right - h_left * hfactor;

    String[] h_vertices = h.substring(start_col+5, h.length()).replaceAll(" R", " ").split(" ");

    for (int i=0; i<h_vertices.length; i++)
    {
      shc.beginShape(LINES);
      for (int j=2; j<h_vertices[i].length (); j+=2)
      {
        float hx0 = pos_x + hershey2coord(h_vertices[i].charAt(j-2)) * hfactor;
        float hy0 = hershey2coord(h_vertices[i].charAt(j-1)) * hfactor;
        shc.vertex(hx0, hy0);
        float hx1 = pos_x + hershey2coord(h_vertices[i].charAt(j)) * hfactor;
        float hy1 = hershey2coord(h_vertices[i].charAt(j+1)) * hfactor;
        shc.vertex(hx1, hy1);
      }
      shc.endShape(CLOSE);
    }
    pos_x += h_width + 5 * hfactor;
    sh.addChild(shc);
  }
  return sh;
}

public void text(String s, int x, int y)
{
  pushMatrix();
  translate(x, y);
  for (int i=0; i<s.length (); i++)
  {
    draw_character(s.charAt(i));
  }
  popMatrix();
}

private float get_character_width(int c)
{
  String h = hershey_font[c - 32 ];

  int start_col = h.indexOf(" ");

  int vertices_length = Integer.parseInt(h.substring(start_col+1, start_col+3).trim());

  int h_left = hershey2coord(h.charAt(start_col+3));
  int h_right = hershey2coord(h.charAt(start_col+4));
  float h_width = h_right - h_left * hfactor;

  return h_width;
}

private void draw_character(int c)
{
  int max_y = -1000;
  int min_y = 1000;

  String h = hershey_font[c - 32 ];

  int start_col = h.indexOf(" ");

  int vertices_length = Integer.parseInt(h.substring(start_col+1, start_col+3).trim());

  int h_left = hershey2coord(h.charAt(start_col+3));
  int h_right = hershey2coord(h.charAt(start_col+4));
  float h_width = h_right - h_left * hfactor;

  String[] h_vertices = h.substring(start_col+5, h.length()).replaceAll(" R", " ").split(" ");

  for (int i=0; i<h_vertices.length; i++)
  {
    beginShape(LINES);
    for (int j=2; j<h_vertices[i].length (); j+=2)
    {
      float hx0 = hershey2coord(h_vertices[i].charAt(j-2)) * hfactor;
      float hy0 = hershey2coord(h_vertices[i].charAt(j-1)) * hfactor;
      vertex(hx0, hy0);
      float hx1 = hershey2coord(h_vertices[i].charAt(j)) * hfactor;
      float hy1 = hershey2coord(h_vertices[i].charAt(j+1)) * hfactor;
      vertex(hx1, hy1);
    }
    endShape(CLOSE);
  }
  translate(h_width + 5 * hfactor, 0);
}

private int hershey2coord(char c)
{
  return c - 'R';
}

private int hershey2int(char c)
{
  return c;
}
