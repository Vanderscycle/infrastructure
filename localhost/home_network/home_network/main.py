from diagrams import Cluster, Diagram
from diagrams.generic.network import Switch, Router, Firewall
from diagrams.generic.place import  Datacenter

with Diagram("Home network", show=False, direction="TB"):
    entrypoint = Router("modem")
    with Cluster("Localhost"):

        internals = Router("Linksys00356") >> Switch("24 poe network switch")
