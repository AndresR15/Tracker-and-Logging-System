gelex -o etf_evt_scanner.e etf_evt_scanner_def.l
geyacc -v etf_evt_decl_parser_out.txt -o etf_evt_decl_parser.e -t etf_evt_tokens etf_evt_decl_parser_def.y 
geyacc -v etf_evt_trace_parser_out.txt -o etf_evt_trace_parser.e -t etf_evt_tokens ETF_evt_trace_parser_def.y 
pause


