function(precharge_source input_c output_s script_path flags common_dir)

    add_custom_command(
        OUTPUT ${output_s}
        COMMAND ${CMAKE_C_COMPILER} "-DSECURITY_LEVEL=128" -I{common_dir} -S "${input_c}" -o "${output_s}"
        COMMENT "RUN ${CMAKE_C_COMPILER} ${flags} -S ${input_c} -o ${output_s}"
        COMMAND python "${script_path}" "${output_s}"
        DEPENDS ${input_c} ${script_path}
    )

    add_custom_target("precharge_${FILENAME}" ALL DEPENDS "${output_s}")
endfunction()