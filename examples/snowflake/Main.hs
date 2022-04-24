import Designs.Snowflake
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

example = snowflake 4 1 # strokeT

main = mainWith (makeCoaster example :: Diagram B)
