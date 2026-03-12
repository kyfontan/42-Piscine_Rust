# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                                                               ┃
# ┃                   R U S T - P I S C I N E                     ┃
# ┃                                                               ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# ━━ Config ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
LATEX         := pdflatex
LATEX_FLAGS   := -interaction=nonstopmode
TEXINPUTS     := ./packages/:
PDF_DIR       := pdf

# All top-level .tex files (excluding templates/)
TEX_FILES     := $(wildcard *.tex)
PDF_FILES     := $(patsubst %.tex,$(PDF_DIR)/%.pdf,$(TEX_FILES))
TOTAL         := $(words $(TEX_FILES))

# LaTeX junk extensions
AUX_EXT       := aux fdb_latexmk fls log out toc synctex.gz

# ━━ Theme ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
R             := \033[0m
B             := \033[1m
D             := \033[2m
I             := \033[3m
WHITE         := \033[38;5;255m
GREEN         := \033[38;5;114m
CYAN          := \033[38;5;81m
BLUE          := \033[38;5;75m
MAGENTA       := \033[38;5;183m
RED           := \033[38;5;210m
YELLOW        := \033[38;5;222m
ORANGE        := \033[38;5;215m
GRAY          := \033[38;5;242m
DARK          := \033[38;5;238m
ACCENT        := \033[38;5;60m

# ━━ Progress ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
COUNT         := 0
BAR_LEN       := 30

define progress
	$(eval COUNT=$(shell echo $$(($(COUNT)+1))))
	$(eval PCT=$(shell echo $$(($(COUNT)*100/$(TOTAL)))))
	$(eval FILLED=$(shell echo $$(($(COUNT)*$(BAR_LEN)/$(TOTAL)))))
	$(eval EMPTY=$(shell echo $$(($(BAR_LEN)-$(FILLED)))))
	@printf "\r  $(GRAY)$(D)│$(R) "
	@printf "$(CYAN)$(B)%3d%%$(R) " $(PCT)
	@printf "$(DARK)"
	@i=0; while [ $$i -lt $(FILLED) ]; do printf "━"; i=$$((i+1)); done
	@printf "$(ACCENT)"
	@i=0; while [ $$i -lt $(EMPTY) ]; do printf "┄"; i=$$((i+1)); done
	@printf "$(R) "
	@printf "$(D)$(GRAY)[$(R)$(WHITE)%2d$(GRAY)$(D)/$(R)$(WHITE)%2d$(GRAY)$(D)]$(R) " $(COUNT) $(TOTAL)
	@printf "$(D)→$(R) $(B)$(WHITE)%-30s$(R)" "$(1)"
	@[ $(COUNT) -eq $(TOTAL) ] && printf "\n" || true
endef

# ━━ Banners ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
define banner
	@printf "\n"
	@printf "  $(ACCENT)┌─────────────────────────────────────────────┐$(R)\n"
	@printf "  $(ACCENT)│$(R)  $(BLUE)$(B)◆$(R)  $(B)$(WHITE)%-40s$(R)$(ACCENT)│$(R)\n" "$(1)"
	@printf "  $(ACCENT)└─────────────────────────────────────────────┘$(R)\n"
	@printf "\n"
endef

define success
	@printf "\n"
	@printf "  $(GREEN)$(B)  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓$(R)\n"
	@printf "  $(GREEN)$(B)  ┃                                           ┃$(R)\n"
	@printf "  $(GREEN)$(B)  ┃   ✦  $(WHITE)Build successful$(GREEN)                     ┃$(R)\n"
	@printf "  $(GREEN)$(B)  ┃      $(R)$(D)$(TOTAL) PDFs → ./$(PDF_DIR)/$(GREEN)                  ┃$(R)\n"
	@printf "  $(GREEN)$(B)  ┃                                           ┃$(R)\n"
	@printf "  $(GREEN)$(B)  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛$(R)\n"
	@printf "\n"
endef

define fail
	@printf "\n"
	@printf "  $(RED)$(B)  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓$(R)\n"
	@printf "  $(RED)$(B)  ┃                                           ┃$(R)\n"
	@printf "  $(RED)$(B)  ┃   ✘  $(WHITE)Compilation failed$(RED)                    ┃$(R)\n"
	@printf "  $(RED)$(B)  ┃      $(R)$(D)Check logs for details$(RED)                ┃$(R)\n"
	@printf "  $(RED)$(B)  ┃                                           ┃$(R)\n"
	@printf "  $(RED)$(B)  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛$(R)\n"
	@printf "\n"
endef

# ━━ Rules ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
all: $(PDF_FILES)
	$(call success)

$(PDF_DIR)/%.pdf: %.tex | $(PDF_DIR)
	$(call progress,$<)
	@TEXINPUTS="$(TEXINPUTS)" $(LATEX) $(LATEX_FLAGS) $< > /dev/null 2>&1 || \
		{ printf "\n  $(RED)$(B)  ✘  Compilation failed:$(R) $(WHITE)$<$(R)\n\n"; exit 1; }
	@TEXINPUTS="$(TEXINPUTS)" $(LATEX) $(LATEX_FLAGS) $< > /dev/null 2>&1
	@mv $*.pdf $(PDF_DIR)/

$(PDF_DIR):
	@mkdir -p $(PDF_DIR)

# ━━ Clean ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
clean:
	$(call banner,Cleaning auxiliary files)
	@$(foreach ext,$(AUX_EXT), rm -f *.$(ext);)
	@printf "  $(YELLOW)$(B)◌$(R)  $(D)Removed:$(R) $(GRAY)$(D)*.{aux,fdb_latexmk,fls,log,out,toc,synctex.gz}$(R)\n"
	@printf "\n"

fclean: clean
	@rm -rf $(PDF_DIR)
	@printf "  $(RED)$(B)◌$(R)  $(D)$(PDF_DIR)/ removed$(R)\n\n"

re: fclean
	@$(MAKE) all --no-print-directory

.PHONY: all clean fclean re

# ━━ Help ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
help:
	@printf "\n"
	@printf "  $(BLUE)$(B)◆  $(WHITE)Piscine Rust$(R) $(D)— available targets$(R)\n"
	@printf "\n"
	@printf "  $(B)$(WHITE)  make$(R)          $(D)Compile all .tex → pdf/$(R)\n"
	@printf "  $(B)$(WHITE)  make clean$(R)    $(D)Remove LaTeX auxiliary files$(R)\n"
	@printf "  $(B)$(WHITE)  make fclean$(R)   $(D)Remove aux files + pdf/$(R)\n"
	@printf "  $(B)$(WHITE)  make re$(R)       $(D)Full rebuild$(R)\n"
	@printf "  $(B)$(WHITE)  make help$(R)     $(D)Show this message$(R)\n"
	@printf "\n"

.PHONY: help