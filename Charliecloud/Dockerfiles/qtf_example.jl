module QFTExample
    # import PicoQuant package
    using PicoQuant

    # create a QFT circuit with 24 qubits
    const circ = create_qft_circuit(24)

    # function to convert to a tensor network and to contract
    function create_network_and_contract(circ; decompose=false, transpile=false)
        tn = convert_qiskit_circ_to_network(circ, decompose=decompose, transpile=transpile)
        add_input!(tn, "0"^tn.number_qubits)
        @time full_wavefunction_contraction!(tn)
    end

    println("Initial contraction includes compilation time")
    create_network_and_contract(circ);
    println("Second run should be more represenative")
    create_network_and_contract(circ);

end
