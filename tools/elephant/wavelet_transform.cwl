#!/usr/bin/env cwl-runner
cwlVersion: v1.2

class: CommandLineTool
baseCommand: wavelet_transform_cli.py

stdout: stdout.txt
stderr: stderr.txt

hints:
  DockerRequirement:
    dockerImageId: docker-registry.ebrains.eu/workflow-components/elephant

doc:
     - "Wavelet transform"
     - "Detailed function documentation: https://elephant.readthedocs.io/en/latest/reference/_toctree/signal_processing/elephant.signal_processing.wavelet_transform.html#elephant.signal_processing.wavelet_transform"

label: elephant-wavelet-transform

# The inputs for this process.
inputs:
  input_file:
    type: File
    label: "A file, containing sampled signals, that can be read by Neo"
    inputBinding:
      prefix: --input_file
  input_format:
    type: string?
    label: "Format of the input data, as a Neo IO class name (optional; TODO: use openMINDS content-types instead?)"
    inputBinding:
      prefix: --input_format
  output_file:
    type: string
    label: "Path to the output file"
    inputBinding:
      prefix: --output_file
  output_format:
    type:
      - "null"
      - type: enum
        symbols:
          - NWBIO
          - NixIO
    label: "Format of the output file (optional). If not provided, will be inferred from the output file suffix"
    inputBinding:
      prefix: --output_format
  block_index:
    type: int?
    label: "Index of the block to process (default: 0)"
    default: 0
    inputBinding:
      prefix: --block_index
  block_name:
    type: string?
    label: "Name of the block to process (optional)"
    inputBinding:
      prefix: --block_name
  segment_index:
    type: int?
    label: "Index of the segment to process (default: 0)"
    default: 0
    inputBinding:
      prefix: --segment_index
  analog_signal_index:
    type: int?
    label: "Index of the analog signal to process (default: 0)"
    default: 0
    inputBinding:
      prefix: --analog_signal_index
  action:
    type: string
    inputBinding:
      prefix: --action
    label: "Action on how to store the results with respect to the original data"
  frequency:
    type: float
    inputBinding:
      prefix: --frequency
    label: "Center frequency of the Morlet wavelet in Hz"
  n_cycles:
    type: float?
    label: "Size of the mother wavelet (default: 6.0)"
    default: 6.0
    inputBinding:
      prefix: --n_cycles
  sampling_frequency:
    type: float?
    label: "Sampling rate of the input data in Hz (default: 1.0)"
    default: 1.0
    inputBinding:
      prefix: --sampling_frequency
  zero_padding:
    type: boolean?
    label: "Specifies whether the data length is extended by padding zeros (default: True)"
    default: true
    inputBinding:
      prefix: --zero_padding

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "$(inputs.output_file)"
  output_stdout:
    type: stdout
  output_stderr:
    type: stderr
