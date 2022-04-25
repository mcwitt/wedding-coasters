import Designs.Snowflake
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

main = mainWith (snowflake 4 :: Diagram B)
