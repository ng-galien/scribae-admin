I18n.translations || (I18n.translations = {});
I18n.translations["en"] = I18n.extend((I18n.translations["en"] || {}), {
  "activerecord": {
    "errors": {
      "messages": {
        "record_invalid": "Validation failed: %{errors}",
        "restrict_dependent_destroy": {
          "has_many": "Cannot delete record because dependent %{record} exist",
          "has_one": "Cannot delete record because a dependent %{record} exists"
        }
      }
    }
  },
  "albums": {
    "edit": {
      "form": {
        "extern": {
          "label": "External",
          "tip": "The album come from another site"
        },
        "intro": {
          "label": "Intro",
          "tip": "Write an introduction for the album"
        },
        "link": {
          "label": "Website",
          "tip": "The website where is the album"
        },
        "title": {
          "label": "Title",
          "tip": "Write the title of the section"
        }
      },
      "invite": "Album edition"
    },
    "index": {
      "create": "Create a new album",
      "empty": "No Album, you must create a new one",
      "invite": "Album list"
    },
    "new": {
      "form": {
        "intro": {
          "label": "Introduction",
          "tip": "Introduction for the album"
        },
        "title": {
          "label": "Title",
          "tip": "Title for the album"
        }
      },
      "invite": "Create a new album"
    }
  },
  "articles": {
    "edit": {
      "form": {
        "date": {
          "label": "Date",
          "tip": "Set the publish date of the article"
        },
        "featured": {
          "label": "Featured",
          "tip": "Choose if the article is features"
        },
        "image": {
          "label": "Image",
          "tip": "Select an illustration for the article"
        },
        "intro": {
          "label": "Introduction",
          "tip": "Write an introduction of the article"
        },
        "markdown": {
          "label": "Article content",
          "tip": "The content of the article"
        },
        "time": {
          "label": "Time",
          "tip": "Set the publish time of the article"
        },
        "title": {
          "label": "Title",
          "tip": "Write the main title of the article"
        }
      },
      "invite": "Article edition"
    },
    "index": {
      "create": "Create article",
      "empty": "No article, create a new one",
      "invite": "Article list"
    },
    "navbar": "Articles",
    "new": {
      "form": {
        "intro": {
          "label": "Introduction",
          "tip": "Write an introduction of the article"
        },
        "title": {
          "label": "Title",
          "tip": "Write the main title of the article"
        }
      },
      "invite": "Create new article"
    }
  },
  "cancel": "Cancel",
  "components": {
    "album": {
      "navbar": "Albums"
    },
    "article": {
      "navbar": "Articles"
    },
    "information": {
      "navbar": "Information"
    },
    "map": {
      "navbar": "Maps"
    },
    "theme": {
      "navbar": "Themes"
    },
    "website": {
      "navbar": "Projects"
    }
  },
  "confirm": "Confirm",
  "confirm-build": "Warning! Are you sure to build?",
  "confirm-delete": "Warning! Are you sure to delete?",
  "date": {
    "abbr_day_names": [
      "Sun",
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat"
    ],
    "abbr_month_names": [
      null,
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ],
    "day_names": [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ],
    "formats": {
      "default": "%Y-%m-%d",
      "long": "%B %d, %Y",
      "short": "%b %d"
    },
    "month_names": [
      null,
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ],
    "order": [
      "year",
      "month",
      "day"
    ]
  },
  "datetime": {
    "distance_in_words": {
      "about_x_hours": {
        "one": "about 1 hour",
        "other": "about %{count} hours"
      },
      "about_x_months": {
        "one": "about 1 month",
        "other": "about %{count} months"
      },
      "about_x_years": {
        "one": "about 1 year",
        "other": "about %{count} years"
      },
      "almost_x_years": {
        "one": "almost 1 year",
        "other": "almost %{count} years"
      },
      "half_a_minute": "half a minute",
      "less_than_x_minutes": {
        "one": "less than a minute",
        "other": "less than %{count} minutes"
      },
      "less_than_x_seconds": {
        "one": "less than 1 second",
        "other": "less than %{count} seconds"
      },
      "over_x_years": {
        "one": "over 1 year",
        "other": "over %{count} years"
      },
      "x_days": {
        "one": "1 day",
        "other": "%{count} days"
      },
      "x_minutes": {
        "one": "1 minute",
        "other": "%{count} minutes"
      },
      "x_months": {
        "one": "1 month",
        "other": "%{count} months"
      },
      "x_seconds": {
        "one": "1 second",
        "other": "%{count} seconds"
      },
      "x_years": {
        "one": "1 year",
        "other": "%{count} years"
      }
    },
    "prompts": {
      "day": "Day",
      "hour": "Hour",
      "minute": "Minute",
      "month": "Month",
      "second": "Seconds",
      "year": "Year"
    }
  },
  "delete": "Delete",
  "edit": "Edit",
  "errors": {
    "connection_refused": "Oops! Failed to connect to the Web Console middleware.\nPlease make sure a rails development server is running.\n",
    "format": "%{attribute} %{message}",
    "messages": {
      "accepted": "must be accepted",
      "blank": "can't be blank",
      "confirmation": "doesn't match %{attribute}",
      "empty": "can't be empty",
      "equal_to": "must be equal to %{count}",
      "even": "must be even",
      "exclusion": "is reserved",
      "greater_than": "must be greater than %{count}",
      "greater_than_or_equal_to": "must be greater than or equal to %{count}",
      "inclusion": "is not included in the list",
      "invalid": "is invalid",
      "less_than": "must be less than %{count}",
      "less_than_or_equal_to": "must be less than or equal to %{count}",
      "model_invalid": "Validation failed: %{errors}",
      "not_a_number": "is not a number",
      "not_an_integer": "must be an integer",
      "odd": "must be odd",
      "other_than": "must be other than %{count}",
      "present": "must be blank",
      "required": "must exist",
      "taken": "has already been taken",
      "too_long": {
        "one": "is too long (maximum is 1 character)",
        "other": "is too long (maximum is %{count} characters)"
      },
      "too_short": {
        "one": "is too short (minimum is 1 character)",
        "other": "is too short (minimum is %{count} characters)"
      },
      "wrong_length": {
        "one": "is the wrong length (should be 1 character)",
        "other": "is the wrong length (should be %{count} characters)"
      }
    },
    "template": {
      "body": "There were problems with the following fields:",
      "header": {
        "one": "1 error prohibited this %{model} from being saved",
        "other": "%{count} errors prohibited this %{model} from being saved"
      }
    },
    "unacceptable_request": "A supported version is expected in the Accept header.\n",
    "unavailable_session": "Session %{id} is no longer available in memory.\n\nIf you happen to run on a multi-process server (like Unicorn or Puma) the process\nthis request hit doesn't store %{id} in memory. Consider turning the number of\nprocesses/workers to one (1) or using a different server in development.\n"
  },
  "false": "No",
  "git": {
    "form": {
      "email": {
        "label": "Account email",
        "tip": "Your account email"
      },
      "invite": "Configure the Github account",
      "password": {
        "label": "User password",
        "tip": "Your account password (not stored by Scribae)"
      },
      "user": {
        "label": "Account name",
        "tip": "Your account login"
      }
    },
    "menu": {
      "commit": {
        "label": null,
        "tip": "Publish to remote website"
      },
      "init": {
        "label": null,
        "tip": "Initialize remote website"
      }
    },
    "message": {
      "commit": "Commit the repository",
      "configure": "Configure the local repository",
      "create": "Create the remote repository on github.com",
      "fail": "Operation failed",
      "init": "Initialize git repository",
      "ssh": "Configure SSH key",
      "sucess": "Operation sucessfull"
    }
  },
  "helpers": {
    "page_entries_info": {
      "entry": {
        "one": "entry",
        "other": "entries",
        "zero": "entries"
      },
      "more_pages": {
        "display_entries": "Displaying %{entry_name} <b>%{first}&nbsp;-&nbsp;%{last}</b> of <b>%{total}</b> in total"
      },
      "one_page": {
        "display_entries": {
          "one": "Displaying <b>1</b> %{entry_name}",
          "other": "Displaying <b>all %{count}</b> %{entry_name}",
          "zero": "No %{entry_name} found"
        }
      }
    },
    "select": {
      "prompt": "Please select"
    },
    "submit": {
      "create": "Create %{model}",
      "submit": "Save %{model}",
      "update": "Update %{model}"
    }
  },
  "i18n": {
    "plural": {
      "keys": [
        "one",
        "other"
      ],
      "rule": "#<Proc:0x00007fb318c0ec48@/Users/alex/.rvm/gems/ruby-2.5-head/gems/rails-i18n-5.1.1/lib/rails_i18n/common_pluralizations/one_other.rb:7 (lambda)>"
    }
  },
  "icons": {
    "invite": "Choose an icon"
  },
  "infos": {
    "edit": {
      "form": {
        "title": {
          "label": "Title",
          "tip": "Write the title of the section"
        }
      },
      "invite": "Section edition"
    },
    "index": {
      "create": "Create a new section",
      "empty": "No section, you must create a new one",
      "invite": "Section list"
    },
    "new": {
      "form": {
        "title": {
          "label": "Title",
          "tip": "Write the section title"
        }
      },
      "invite": "Create a new theme"
    }
  },
  "menu": {
    "back": {
      "label": "Project",
      "tip": "Back to project"
    },
    "new": {
      "label": "New",
      "tip": "Create new item"
    },
    "sort": {
      "label": "Sort",
      "tip": "Sort items"
    }
  },
  "number": {
    "currency": {
      "format": {
        "delimiter": ",",
        "format": "%u%n",
        "precision": 2,
        "separator": ".",
        "significant": false,
        "strip_insignificant_zeros": false,
        "unit": "$"
      }
    },
    "format": {
      "delimiter": ",",
      "precision": 3,
      "separator": ".",
      "significant": false,
      "strip_insignificant_zeros": false
    },
    "human": {
      "decimal_units": {
        "format": "%n %u",
        "units": {
          "billion": "Billion",
          "million": "Million",
          "quadrillion": "Quadrillion",
          "thousand": "Thousand",
          "trillion": "Trillion",
          "unit": ""
        }
      },
      "format": {
        "delimiter": "",
        "precision": 3,
        "significant": true,
        "strip_insignificant_zeros": true
      },
      "storage_units": {
        "format": "%n %u",
        "units": {
          "byte": {
            "one": "Byte",
            "other": "Bytes"
          },
          "eb": "EB",
          "gb": "GB",
          "kb": "KB",
          "mb": "MB",
          "pb": "PB",
          "tb": "TB"
        }
      }
    },
    "percentage": {
      "format": {
        "delimiter": "",
        "format": "%n%"
      }
    },
    "precision": {
      "format": {
        "delimiter": ""
      }
    }
  },
  "preview": {
    "message": {
      "bundle": {
        "end": "Bundle update terminated",
        "error": "Bundle update fail!",
        "start": "Bundle is updating..."
      },
      "fail": "Operation failed",
      "jekyll": {
        "end": "Jekyll terminated",
        "error": "Jekyll error while running!",
        "start": "Starting Jekyll..",
        "started": "Jekyll is started"
      },
      "job": {
        "after": "After preview job",
        "album": "Update albums",
        "article": "Update articles",
        "component": "Update components",
        "config": "Create preview config",
        "home": "Update home page",
        "info": "Update infos",
        "start": "Start the preview job",
        "static": "Create prototype structure",
        "style": "Update style",
        "theme": "Update themes"
      },
      "start": "Start the preview",
      "stop": "Stop the preview server",
      "sucess": "Operation sucessfull"
    },
    "trigger": {
      "clear": "clear",
      "error": "error",
      "page": "page",
      "status": "status",
      "update": "update",
      "value": {
        "run": "run",
        "stop": "stop"
      }
    },
    "wait": "Waiting for site editing"
  },
  "return_to_list": "Return to list",
  "save": "Save",
  "sortable": {
    "invite": "Drag to sort items"
  },
  "style": {
    "defaut": null
  },
  "support": {
    "array": {
      "last_word_connector": ", and ",
      "two_words_connector": " and ",
      "words_connector": ", "
    }
  },
  "terminal": {
    "cmd": "> EXEC:",
    "error": "ERROR",
    "info": "INFO:"
  },
  "themes": {
    "edit": {
      "form": {
        "intro": {
          "label": "Introduction",
          "tip": "tip"
        },
        "title": {
          "label": "Title",
          "tip": "tip"
        }
      },
      "invite": "Theme edition"
    },
    "index": {
      "create": "Create a new theme",
      "empty": "No themes, you must create a new one",
      "invite": "Themes list"
    },
    "new": {
      "form": {
        "intro": {
          "label": "Introduction",
          "tip": "tip"
        },
        "title": {
          "label": "Title",
          "tip": "tip"
        }
      },
      "invite": "Create a new theme"
    }
  },
  "time": {
    "am": "am",
    "formats": {
      "default": "%d/%m/%y %H:%M",
      "long": "%B %d, %Y",
      "short": "%b %d"
    },
    "pm": "pm"
  },
  "true": "Yes",
  "views": {
    "pagination": {
      "first": "&laquo; First",
      "last": "Last &raquo;",
      "next": "Next &rsaquo;",
      "previous": "&lsaquo; Prev",
      "truncate": "&hellip;"
    }
  },
  "wait_message": "Please wait while processing...",
  "websites": {
    "default": {
      "article": {
        "fake": {
          "date": "01/01/2000",
          "intro": "Read the article introduction",
          "title": "Sample article"
        }
      },
      "bottom_intro": "Bottom intro",
      "bottom_title": "Bottom title",
      "components": {
        "albums": {
          "icon": "camera_roll",
          "intro": "See the albums",
          "show": true,
          "title": "Albums"
        },
        "articles": {
          "icon": "flash_on",
          "intro": "Follow latest articles",
          "show": true,
          "title": "Articles"
        },
        "infos": {
          "icon": "info_outline",
          "intro": "Full information",
          "show": true,
          "title": "Information"
        },
        "maps": {
          "icon": "camera_roll",
          "intro": "Explore maps",
          "show": false,
          "title": "Map"
        },
        "themes": {
          "icon": "accessible",
          "intro": "Discover the themes",
          "show": true,
          "title": "Theme"
        }
      },
      "featured_title": "Featured posts",
      "home_icon": "home",
      "home_title": "Home",
      "markdown": "# Content title \\n\\n Write the content here",
      "site_title": "",
      "top_intro": "Top intro",
      "top_title": "Top title"
    },
    "edit": {
      "component": {
        "form": {
          "icon": {
            "label": "Choose a icon",
            "tip": ""
          },
          "intro": {
            "label": "The text intro",
            "tip": ""
          },
          "markdown": {
            "label": "Text for the module",
            "tip": "Longer text on the module page"
          },
          "show": {
            "label": "Show this on the website",
            "tip": ""
          },
          "show_markdown": {
            "label": "Show text",
            "tip": "Show longer text on the module page"
          },
          "theme": {
            "label": "Choose a theme",
            "tip": ""
          },
          "title": {
            "label": "The primary label",
            "tip": ""
          }
        },
        "invite": "Customize components",
        "title": "Components"
      },
      "form": {
        "background": {
          "label": "Background color",
          "tip": "Tip"
        },
        "decoration": {
          "label": "Decoration color",
          "tip": "Tip"
        },
        "description": {
          "label": "Description",
          "tip": "Write a short description of your project"
        },
        "helper": {
          "label": "Additional style",
          "tip": "Tip"
        },
        "icon": {
          "label": "Icon color",
          "tip": "Tip"
        },
        "name": {
          "label": "Name",
          "tip": "The name of the project for your website"
        },
        "navbar": {
          "label": "Navbar color",
          "tip": "Tip"
        },
        "primary": {
          "label": "Primary color",
          "tip": "Tip"
        },
        "secondary": {
          "label": "Secondary color",
          "tip": "Tip"
        },
        "text": {
          "label": "Text color",
          "tip": "Tip"
        }
      },
      "home": {
        "form": {
          "bottom_image": {
            "label": "Select the bottom image",
            "tip": "Click to change the top image"
          },
          "bottom_intro": {
            "label": "Bottom intro",
            "tip": "The text that follow the bottom title"
          },
          "bottom_title": {
            "label": "Bottom title",
            "tip": "The big tile on the second image"
          },
          "featured_title": {
            "label": "Featured posts",
            "tip": "Text introduicing featured articles"
          },
          "markdown": {
            "label": "Puts your text here'",
            "tip": "The bottom text is at the end of the page"
          },
          "show_featured": {
            "label": "Show featured",
            "tip": "Show featuread articles"
          },
          "show_markdown": {
            "label": "Show bottom text",
            "tip": "The bottom text is at the end of the page"
          },
          "title": {
            "label": "Site head title",
            "tip": "The site title will be available on the browser head"
          },
          "top_image": {
            "label": "Select the top image",
            "tip": "Click to change the top image"
          },
          "top_intro": {
            "label": "Top intro",
            "tip": "The text that follow the top title"
          },
          "top_title": {
            "label": "The title on top",
            "tip": "The big tile on the first image"
          }
        },
        "invite": "Set the home page",
        "title": "home page"
      },
      "invite": "Website main page edition",
      "menu": {
        "back": "Return to websites list",
        "preview": "open the preview",
        "settings": "Edit settings",
        "style": "Edit colors style"
      },
      "parameters": "Parameters",
      "settings": {
        "form": {
          "description": {
            "label": "Description of the project",
            "tip": ""
          },
          "project": {
            "label": "Name of the project",
            "tip": ""
          },
          "readme": {
            "label": "Read me of the repo",
            "tip": ""
          },
          "repo": {
            "label": "Github repository",
            "tip": ""
          },
          "token": {
            "label": "Token of the repo",
            "tip": ""
          },
          "url": {
            "label": "URL of the website",
            "tip": ""
          }
        },
        "invite": "Project properties",
        "title": "Settings"
      }
    },
    "index": {
      "create": "Create a new project",
      "edit": "Edit website",
      "empty": "No projects, you must first create a new one",
      "invite": "Welcome to Sribae website creator",
      "select": "Enter in Website"
    },
    "navbar": "Projects",
    "new": {
      "invite": "New Project"
    }
  }
});
I18n.translations["fr"] = I18n.extend((I18n.translations["fr"] || {}), {
  "activerecord": {
    "errors": {
      "messages": {
        "record_invalid": "La validation a échoué : %{errors}",
        "restrict_dependent_destroy": {
          "has_many": "Vous ne pouvez pas supprimer l'enregistrement parce que les %{record} dépendants existent",
          "has_one": "Vous ne pouvez pas supprimer l'enregistrement car un(e) %{record} dépendant(e) existe"
        }
      }
    }
  },
  "albums": {
    "edit": {
      "form": {
        "extern": {
          "label": "External",
          "tip": "The album come from another site"
        },
        "intro": {
          "label": "Intro",
          "tip": "Write an introduction for the album"
        },
        "link": {
          "label": "Website",
          "tip": "The website where is the album"
        },
        "title": {
          "label": "Title",
          "tip": "Write the title of the section"
        }
      },
      "invite": "Album edition"
    },
    "index": {
      "create": "Create a new album",
      "empty": "No Album, you must create a new one",
      "invite": "Album list"
    },
    "new": {
      "form": {
        "intro": {
          "label": "Introduction",
          "tip": "Introduction for the album"
        },
        "title": {
          "label": "Title",
          "tip": "Title for the album"
        }
      },
      "invite": "Create a new album"
    }
  },
  "articles": {
    "edit": {
      "form": {
        "date": {
          "label": "Date",
          "tip": "Set the publish date of the article"
        },
        "featured": {
          "label": "Featured",
          "tip": "Choose if the article is features"
        },
        "image": {
          "label": "Image",
          "tip": "Select an illustration for the article"
        },
        "intro": {
          "label": "Introduction",
          "tip": "Write an introduction of the article"
        },
        "markdown": {
          "label": "Article content",
          "tip": "The content of the article"
        },
        "time": {
          "label": "Time",
          "tip": "Set the publish time of the article"
        },
        "title": {
          "label": "Title",
          "tip": "Write the main title of the article"
        }
      },
      "invite": "Article edition"
    },
    "index": {
      "create": "Create article",
      "empty": "No article, create a new one",
      "invite": "Article list"
    },
    "navbar": "Articles",
    "new": {
      "form": {
        "intro": {
          "label": "Introduction",
          "tip": "Write an introduction of the article"
        },
        "title": {
          "label": "Title",
          "tip": "Write the main title of the article"
        }
      },
      "invite": "Create new article"
    }
  },
  "cancel": "Annuler",
  "components": {
    "album": {
      "navbar": "Albums"
    },
    "article": {
      "navbar": "Articles"
    },
    "information": {
      "navbar": "Information"
    },
    "map": {
      "navbar": "Cartes"
    },
    "theme": {
      "navbar": "Themes"
    },
    "website": {
      "navbar": "Projets"
    }
  },
  "confirm": "Confirmer",
  "confirm-build": "Attention! Etes-vous certain de construire?",
  "confirm-delete": "Attention! Etes vous certain de supprimer?",
  "date": {
    "abbr_day_names": [
      "dim",
      "lun",
      "mar",
      "mer",
      "jeu",
      "ven",
      "sam"
    ],
    "abbr_month_names": [
      null,
      "jan.",
      "fév.",
      "mar.",
      "avr.",
      "mai",
      "juin",
      "juil.",
      "août",
      "sept.",
      "oct.",
      "nov.",
      "déc."
    ],
    "day_names": [
      "dimanche",
      "lundi",
      "mardi",
      "mercredi",
      "jeudi",
      "vendredi",
      "samedi"
    ],
    "formats": {
      "default": "%d/%m/%Y",
      "long": "%e %B %Y",
      "short": "%e %b"
    },
    "month_names": [
      null,
      "janvier",
      "février",
      "mars",
      "avril",
      "mai",
      "juin",
      "juillet",
      "août",
      "septembre",
      "octobre",
      "novembre",
      "décembre"
    ],
    "order": [
      "day",
      "month",
      "year"
    ]
  },
  "datetime": {
    "distance_in_words": {
      "about_x_hours": {
        "one": "environ une heure",
        "other": "environ %{count} heures"
      },
      "about_x_months": {
        "one": "environ un mois",
        "other": "environ %{count} mois"
      },
      "about_x_years": {
        "one": "environ un an",
        "other": "environ %{count} ans"
      },
      "almost_x_years": {
        "one": "presqu'un an",
        "other": "presque %{count} ans"
      },
      "half_a_minute": "une demi-minute",
      "less_than_x_minutes": {
        "one": "moins d'une minute",
        "other": "moins de %{count} minutes",
        "zero": "moins d'une minute"
      },
      "less_than_x_seconds": {
        "one": "moins d'une seconde",
        "other": "moins de %{count} secondes",
        "zero": "moins d'une seconde"
      },
      "over_x_years": {
        "one": "plus d'un an",
        "other": "plus de %{count} ans"
      },
      "x_days": {
        "one": "1 jour",
        "other": "%{count} jours"
      },
      "x_minutes": {
        "one": "1 minute",
        "other": "%{count} minutes"
      },
      "x_months": {
        "one": "1 mois",
        "other": "%{count} mois"
      },
      "x_seconds": {
        "one": "1 seconde",
        "other": "%{count} secondes"
      },
      "x_years": {
        "one": "un an",
        "other": "%{count} ans"
      }
    },
    "prompts": {
      "day": "Jour",
      "hour": "Heure",
      "minute": "Minute",
      "month": "Mois",
      "second": "Seconde",
      "year": "Année"
    }
  },
  "delete": "Supprimer",
  "edit": "Editer",
  "errors": {
    "connection_refused": "Oops! Failed to connect to the Web Console middleware.\nPlease make sure a rails development server is running.\n",
    "format": "%{attribute} %{message}",
    "messages": {
      "accepted": "doit être accepté(e)",
      "blank": "doit être rempli(e)",
      "confirmation": "ne concorde pas avec %{attribute}",
      "empty": "doit être rempli(e)",
      "equal_to": "doit être égal à %{count}",
      "even": "doit être pair",
      "exclusion": "n'est pas disponible",
      "greater_than": "doit être supérieur à %{count}",
      "greater_than_or_equal_to": "doit être supérieur ou égal à %{count}",
      "inclusion": "n'est pas inclus(e) dans la liste",
      "invalid": "n'est pas valide",
      "less_than": "doit être inférieur à %{count}",
      "less_than_or_equal_to": "doit être inférieur ou égal à %{count}",
      "model_invalid": "Validation échouée : %{errors}",
      "not_a_number": "n'est pas un nombre",
      "not_an_integer": "doit être un nombre entier",
      "odd": "doit être impair",
      "other_than": "doit être différent de %{count}",
      "present": "doit être vide",
      "required": "doit exister",
      "taken": "n'est pas disponible",
      "too_long": {
        "one": "est trop long (pas plus d'un caractère)",
        "other": "est trop long (pas plus de %{count} caractères)"
      },
      "too_short": {
        "one": "est trop court (au moins un caractère)",
        "other": "est trop court (au moins %{count} caractères)"
      },
      "wrong_length": {
        "one": "ne fait pas la bonne longueur (doit comporter un seul caractère)",
        "other": "ne fait pas la bonne longueur (doit comporter %{count} caractères)"
      }
    },
    "template": {
      "body": "Veuillez vérifier les champs suivants : ",
      "header": {
        "one": "Impossible d'enregistrer ce(tte) %{model} : 1 erreur",
        "other": "Impossible d'enregistrer ce(tte) %{model} : %{count} erreurs"
      }
    },
    "unacceptable_request": "A supported version is expected in the Accept header.\n",
    "unavailable_session": "Session %{id} is no longer available in memory.\n\nIf you happen to run on a multi-process server (like Unicorn or Puma) the process\nthis request hit doesn't store %{id} in memory. Consider turning the number of\nprocesses/workers to one (1) or using a different server in development.\n"
  },
  "false": "Non",
  "git": {
    "form": {
      "email": {
        "label": "Account email",
        "tip": "Your account email"
      },
      "invite": "Configure the Github account",
      "password": {
        "label": "User password",
        "tip": "Your account password (not stored by Scribae)"
      },
      "user": {
        "label": "Account name",
        "tip": "Your account login"
      }
    },
    "menu": {
      "commit": {
        "label": null,
        "tip": "Publish to remote website"
      },
      "init": {
        "label": null,
        "tip": "Initialize remote website"
      }
    },
    "message": {
      "commit": "Commit the repository",
      "configure": "Configure the local repository",
      "create": "Create the remote repository on github.com",
      "fail": "Operation failed",
      "init": "Initialize git repository",
      "ssh": "Configure SSH key",
      "sucess": "Operation sucessfull"
    }
  },
  "helpers": {
    "page_entries_info": {
      "entry": {
        "one": "entry",
        "other": "entries",
        "zero": "entries"
      },
      "more_pages": {
        "display_entries": "Displaying %{entry_name} <b>%{first}&nbsp;-&nbsp;%{last}</b> of <b>%{total}</b> in total"
      },
      "one_page": {
        "display_entries": {
          "one": "Displaying <b>1</b> %{entry_name}",
          "other": "Displaying <b>all %{count}</b> %{entry_name}",
          "zero": "No %{entry_name} found"
        }
      }
    },
    "select": {
      "prompt": "Veuillez sélectionner"
    },
    "submit": {
      "create": "Créer un(e) %{model}",
      "submit": "Enregistrer ce(tte) %{model}",
      "update": "Modifier ce(tte) %{model}"
    }
  },
  "i18n": {
    "plural": {
      "keys": [
        "one",
        "other"
      ],
      "rule": "#<Proc:0x00007fb318c0c240@/Users/alex/.rvm/gems/ruby-2.5-head/gems/rails-i18n-5.1.1/lib/rails_i18n/common_pluralizations/one_upto_two_other.rb:7 (lambda)>"
    },
    "transliterate": {
      "rule": {
        "À": "A",
        "Â": "A",
        "Æ": "Ae",
        "Ç": "C",
        "È": "E",
        "É": "E",
        "Ê": "E",
        "Ë": "E",
        "Î": "I",
        "Ï": "I",
        "Ô": "O",
        "Ù": "U",
        "Û": "U",
        "Ü": "U",
        "à": "a",
        "â": "a",
        "æ": "ae",
        "ç": "c",
        "è": "e",
        "é": "e",
        "ê": "e",
        "ë": "e",
        "î": "i",
        "ï": "i",
        "ô": "o",
        "ù": "u",
        "û": "u",
        "ü": "u",
        "ÿ": "y",
        "Œ": "Oe",
        "œ": "oe",
        "Ÿ": "Y"
      }
    }
  },
  "icons": {
    "invite": "Choisir un icone"
  },
  "infos": {
    "edit": {
      "form": {
        "title": {
          "label": "Title",
          "tip": "Write the title of the section"
        }
      },
      "invite": "Section edition"
    },
    "index": {
      "create": "Create a new section",
      "empty": "No section, you must create a new one",
      "invite": "Section list"
    },
    "new": {
      "form": {
        "title": {
          "label": "Title",
          "tip": "Write the section title"
        }
      },
      "invite": "Create a new theme"
    }
  },
  "menu": {
    "back": {
      "label": "Project",
      "tip": "Retour au project"
    },
    "new": {
      "label": "Nouveau",
      "tip": "Créer un nouveau"
    },
    "sort": {
      "label": "Trier",
      "tip": "Tirer les élàments"
    }
  },
  "number": {
    "currency": {
      "format": {
        "delimiter": " ",
        "format": "%n %u",
        "precision": 2,
        "separator": ",",
        "significant": false,
        "strip_insignificant_zeros": false,
        "unit": "€"
      }
    },
    "format": {
      "delimiter": " ",
      "precision": 3,
      "separator": ",",
      "significant": false,
      "strip_insignificant_zeros": false
    },
    "human": {
      "decimal_units": {
        "format": "%n %u",
        "units": {
          "billion": "milliard",
          "million": "million",
          "quadrillion": "million de milliards",
          "thousand": "millier",
          "trillion": "billion",
          "unit": ""
        }
      },
      "format": {
        "delimiter": "",
        "precision": 3,
        "significant": true,
        "strip_insignificant_zeros": true
      },
      "storage_units": {
        "format": "%n %u",
        "units": {
          "byte": {
            "one": "octet",
            "other": "octets"
          },
          "eb": "EB",
          "gb": "Go",
          "kb": "ko",
          "mb": "Mo",
          "pb": "PB",
          "tb": "To"
        }
      }
    },
    "percentage": {
      "format": {
        "delimiter": "",
        "format": "%n%"
      }
    },
    "precision": {
      "format": {
        "delimiter": ""
      }
    }
  },
  "preview": {
    "message": {
      "bundle": {
        "end": "Bundle update terminated",
        "error": "Bundle update fail!",
        "start": "Bundle is updating..."
      },
      "fail": "Operation failed",
      "jekyll": {
        "end": "Jekyll terminated",
        "error": "Jekyll error while running!",
        "start": "Starting Jekyll..",
        "started": "Jekyll is started"
      },
      "job": {
        "after": "After preview job",
        "album": "Update albums",
        "article": "Update articles",
        "component": "Update components",
        "config": "Create preview config",
        "home": "Update home page",
        "info": "Update infos",
        "start": "Start the preview job",
        "static": "Create prototype structure",
        "style": "Update style",
        "theme": "Update themes"
      },
      "start": "Start the preview",
      "stop": "Stop the preview server",
      "sucess": "Operation sucessfull"
    },
    "trigger": {
      "clear": "clear",
      "error": "error",
      "page": "page",
      "status": "status",
      "update": "update",
      "value": {
        "run": "run",
        "stop": "stop"
      }
    },
    "wait": "Waiting for site editing"
  },
  "return_to_list": "Retour à la liste",
  "save": "Sauvegarder",
  "sortable": {
    "invite": "Glisser pour trier"
  },
  "style": {
    "defaut": null
  },
  "support": {
    "array": {
      "last_word_connector": " et ",
      "two_words_connector": " et ",
      "words_connector": ", "
    }
  },
  "terminal": {
    "cmd": "> EXEC:",
    "error": "ERROR",
    "info": "INFO:"
  },
  "themes": {
    "edit": {
      "form": {
        "intro": {
          "label": "Introduction",
          "tip": "tip"
        },
        "title": {
          "label": "Title",
          "tip": "tip"
        }
      },
      "invite": "Theme edition"
    },
    "index": {
      "create": "Create a new theme",
      "empty": "No themes, you must create a new one",
      "invite": "Themes list"
    },
    "new": {
      "form": {
        "intro": {
          "label": "Introduction",
          "tip": "tip"
        },
        "title": {
          "label": "Title",
          "tip": "tip"
        }
      },
      "invite": "Create a new theme"
    }
  },
  "time": {
    "am": "am",
    "formats": {
      "default": "%d/%m/%y %H:%M",
      "long": "%B %d, %Y",
      "short": "%b %d"
    },
    "pm": "pm"
  },
  "true": "Oui",
  "views": {
    "pagination": {
      "first": "&laquo; First",
      "last": "Last &raquo;",
      "next": "Next &rsaquo;",
      "previous": "&lsaquo; Prev",
      "truncate": "&hellip;"
    }
  },
  "wait_message": "Attendre pendant le traitement...",
  "websites": {
    "default": {
      "article": {
        "fake": {
          "date": "01/01/2000",
          "intro": "Read the article introduction",
          "title": "Sample article"
        }
      },
      "bottom_intro": "Introduction second",
      "bottom_title": "Titre second",
      "components": {
        "albums": {
          "icon": "camera_roll",
          "intro": "Voir les albums",
          "show": true,
          "title": "Albums"
        },
        "articles": {
          "icon": "flash_on",
          "intro": "Suivre les denriers articles",
          "show": true,
          "title": "Articles"
        },
        "infos": {
          "icon": "info_outline",
          "intro": "En savoir plus",
          "show": true,
          "title": "Information"
        },
        "maps": {
          "icon": "camera_roll",
          "intro": "Explorer les cartes",
          "show": false,
          "title": "Carte"
        },
        "themes": {
          "icon": "accessible",
          "intro": "Découvrez les themes",
          "show": true,
          "title": "Theme"
        }
      },
      "featured_title": "Articles en une",
      "home_icon": "home",
      "home_title": "Accueil",
      "markdown": "",
      "site_title": "",
      "top_intro": "Introduction première",
      "top_title": "Titre premier"
    },
    "edit": {
      "component": {
        "form": {
          "icon": {
            "label": "Choose a icon",
            "tip": ""
          },
          "intro": {
            "label": "The text intro",
            "tip": ""
          },
          "markdown": {
            "label": "Text for the module",
            "tip": "Longer text on the module page"
          },
          "show": {
            "label": "Show this on the website",
            "tip": ""
          },
          "show_markdown": {
            "label": "Show text",
            "tip": "Show longer text on the module page"
          },
          "theme": {
            "label": "Choose a theme",
            "tip": ""
          },
          "title": {
            "label": "The primary label",
            "tip": ""
          }
        },
        "invite": "Customize components",
        "title": "Components"
      },
      "form": {
        "background": {
          "label": "Background color",
          "tip": "Tip"
        },
        "decoration": {
          "label": "Decoration color",
          "tip": "Tip"
        },
        "description": {
          "label": "Description",
          "tip": "Write a short description of your project"
        },
        "helper": {
          "label": "Additional style",
          "tip": "Tip"
        },
        "icon": {
          "label": "Icon color",
          "tip": "Tip"
        },
        "name": {
          "label": "Name",
          "tip": "The name of the project for your website"
        },
        "navbar": {
          "label": "Navbar color",
          "tip": "Tip"
        },
        "primary": {
          "label": "Primary color",
          "tip": "Tip"
        },
        "secondary": {
          "label": "Secondary color",
          "tip": "Tip"
        },
        "text": {
          "label": "Text color",
          "tip": "Tip"
        }
      },
      "home": {
        "form": {
          "bottom_image": {
            "label": "Select the bottom image",
            "tip": "Click to change the top image"
          },
          "bottom_intro": {
            "label": "Bottom intro",
            "tip": "The text that follow the bottom title"
          },
          "bottom_title": {
            "label": "Bottom title",
            "tip": "The big tile on the second image"
          },
          "featured_title": {
            "label": "Featured posts",
            "tip": "Text introduicing featured articles"
          },
          "markdown": {
            "label": "Puts your text here'",
            "tip": "The bottom text is at the end of the page"
          },
          "show_featured": {
            "label": "Show featured",
            "tip": "Show featuread articles"
          },
          "show_markdown": {
            "label": "Show bottom text",
            "tip": "The bottom text is at the end of the page"
          },
          "title": {
            "label": "Site head title",
            "tip": "The site title will be available on the browser head"
          },
          "top_image": {
            "label": "Select the top image",
            "tip": "Click to change the top image"
          },
          "top_intro": {
            "label": "Top intro",
            "tip": "The text that follow the top title"
          },
          "top_title": {
            "label": "The title on top",
            "tip": "The big tile on the first image"
          }
        },
        "invite": "Set the home page",
        "title": "home page"
      },
      "invite": "Website main page edition",
      "menu": {
        "back": "Return to websites list",
        "preview": "open the preview",
        "settings": "Edit settings",
        "style": "Edit colors style"
      },
      "parameters": "Parameters",
      "settings": {
        "form": {
          "description": {
            "label": "Description of the project",
            "tip": ""
          },
          "project": {
            "label": "Name of the project",
            "tip": ""
          },
          "readme": {
            "label": "Read me of the repo",
            "tip": ""
          },
          "repo": {
            "label": "Github repository",
            "tip": ""
          },
          "token": {
            "label": "Token of the repo",
            "tip": ""
          },
          "url": {
            "label": "URL of the website",
            "tip": ""
          }
        },
        "invite": "Project properties",
        "title": "Settings"
      }
    },
    "index": {
      "create": "Créer un mouvea projet",
      "edit": "Editer le site",
      "empty": "Aucun projet, commencer par créer un projet",
      "invite": "Bienvenue dans l'éditeur Scribae",
      "select": "Entrer dans le projet"
    },
    "navbar": "Projets",
    "new": {
      "invite": "Nouveau projet"
    }
  }
});
