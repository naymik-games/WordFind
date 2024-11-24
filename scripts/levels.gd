extends Node

var levels = {
	"11": ["puzzle", "search", "word", "clue", "cross", "find"],
	"12": ["computer", "monitor", "mouse", "drive", "keys","printer"],
	"13": ["house", "room", "door", "kitchen", "yard", "window","key"],
	"14": ["rebel","luke","lea","wedge","hansolo","scum"],
	"15": ["serious","church","school", "work","grave", "court"],
	"16": ["nature","tree", "flower","weed","animal","cloud", "grass"],
	"17": ["forest", "canopy","trees","deer","squirel","leaves","fern"],
	"18": ["pets","snake","dog","hamster", "lizard","cat","bird","pony"],
	#####
	"21": ["green", "recycle", "reuse","compost", "organic","renew","reduce"],
	"22": ["sports", "ball", "diamond","goal","field","referee","clock"],
	"23": ["white", "cloud", "ivory", "snow", "tooth", "vanilla"],
	"24": ["hobbit","bilbo", "frodo","pippen","mary","samwise","gaffer"],
	"25": ["desk","staple", "pencil","papers","blotter","inbox","drawer"],
	"26": ["book","mark", "case","worm","shelf","binding","store"],
	"27": ["pollution","plastic","air","water","toxic","garbage","carbon"],
	"28": ["red", "nose", "apple", "devil", "lips", "rover", "scare", "brick"],
	#####
	"31": ["black", "coal", "night", "tuxedo", "spider"],
	"32": ["outdoor","camping", "climb", "cycle", "hike", "run", "sail"],
	"33": ["water", "boats", "fish", "rocks", "seaweed", "trash", "whales"],
	"34": ["learn", "library", "museum", "school", "zoo", "internet"],
	"35": ["place", "diner", "home", "office", "shop", "store"],
	"36": ["live","apartment", "house", "hut", "mansion", "tent", "trailer"],
	"37": ["fun","beach", "nightclub", "park", "pool","theater"],
	"38": ["colors","rainbow", "people", "flowers", "prism"]
}
"""
levels = [

  ap: true, words: ["leaves", "eyes", "alligator", "envy", "light"] },
  : false, words: ["rainbow", "people", "flowers", "prism"] },

  p: false, words: ["ferns", "canopy", "redwood", "owls", "trails"] },
  lap: true, words: ["pollution", "extinct", "warming", "plastics"] },

   false, words:  },

  lse, words:  },
  e, words:  },
  ap: false, words: ["cemetery", "church", "court", "funeral"] },

  e,

  rue, words: ["speeder", "tie", "xwing", "falcon", "destroyer", "transport"] },
  e, words: ["hansolo", "chewbacca", "luke", "lea", "obiwan", "darthvader", "padme", "palpatine"] },
   true, words: ["deathstar", "endor", "tattooine", "hoth", "naboo", "alderon", "cloudcity"] },
  erlap: true, words: ["Quigon", "darthmaul", "emperor", "bobafett", "ray", "finn", "bensolo", "monmotha", "phasma", "tarkin"] },
  ue, words: ["lightsaber", "blaster", "droids", "carbonite", "force", "jedi", "plans", "shields", "hyperspace"] },

  ue, words: ["bilbo", "frodo", "peregrin", "merry", "samwise", "lobelia", "proudfoot", "rose", "gaffer"] },
   words: ["gandolf", "treebeard", "galadriell", "elrond", "elfstone", "gimli", "bombadil", "smeagol"] },
  words: ["sauron", "saruman", "wormtounge", "witchking", "barlog", "orc", "gollum", "ted", "gorbag"] },
  e, words: ["shire", "rivendell", "lorien", "mordor", "rohan", "minastirith", "moria", "helmsdeep", "isengard"] },
  , words: ["aragorn", "andural", "butterbur", "weed", "ring", "havens", "elves", "bagend", "sharky", "partytree", "potato"] },

  ue, words: ["keyboard", "mouse", "monitor", "harddrive", "printer", "server", "cable", "modem", "network"] },
  ue, words: ["word", "excel", "outlook", "paint", "teams", "notepad", "chrome", "explorer"] },
  ue, words: ["crash", "virus", "phishing", "malware", "overheat", "whitescreen", "offline",] },
  , words: ["function", "editor", "git", "script", "code", "variable", "method", "python", "basic", "java"] },
  ue, words: ["wifi", "browser", "popup", "domain", "google", "bing", "online", "facebook", "twitter", "instagram"] },

  e, words: ["chihuahua", "bulldog", "terrier", "collie", "shepherd", "boxer", "hound", "beagle", "rottweiler", "pinsher", "mastiff"] },
  rue, words: ["lion", "leopard", "cheetah", "rhino", "elephant", "hippo", "giraffe", "hyena", "gazelle", "warthog", "monkey"] },
  e, words: ["dog", "cat", "hamster", "fish", "bird", "snake", "iguana", "ferret", "gerbil", "lizard", "turtle"] },
  ap: true, words: ["cow", "goat", "pig", "chicken", "sheep", "turkey", "horse", "llama", "buffalo", "rooster"] },
   true, words: ["crocodile", "dingo", "shark", "cobra", "gator", "tarantula", "scorpian", "anaconda", "wolf", "stingray"] },
];
"""
