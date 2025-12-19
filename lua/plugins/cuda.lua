-- CUDA Development Configuration
-- LSP (clangd with CUDA support), formatting, and nvcc integration

return {
  -- TreeSitter parsers for CUDA
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "cuda",
        "cpp", -- CUDA is based on C++
      })
    end,
  },

  -- Set filetype for CUDA files
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.filetype.add({
        extension = {
          cu = "cuda",
          cuh = "cuda",
        },
      })
    end,
  },

  -- Clangd LSP with CUDA support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            -- CUDA support
            "--cuda-gpu-arch=sm_75", -- Adjust for your GPU
            "--cuda-path=/usr/local/cuda", -- Adjust for your CUDA path
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
          root_dir = function(fname)
            local lspconfig = require("lspconfig")
            return lspconfig.util.root_pattern(
              "compile_commands.json",
              "compile_flags.txt",
              "Makefile",
              "CMakeLists.txt",
              ".git"
            )(fname) or vim.fn.getcwd()
          end,
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
    },
  },

  -- Code formatting with clang-format
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cuda = { "clang_format" },
      },
    },
  },

  -- CUDA-specific keybindings
  {
    "neovim/nvim-lspconfig",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "cuda" },
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "CUDA: " .. desc })
          end

          -- Compilation
          map("<leader>cc", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal nvcc -o " .. out .. " " .. file)
          end, "Compile (nvcc)")

          map("<leader>cC", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal nvcc -O3 -o " .. out .. " " .. file)
          end, "Compile (optimized)")

          map("<leader>cg", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal nvcc -g -G -o " .. out .. " " .. file)
          end, "Compile (debug)")

          map("<leader>ca", function()
            local file = vim.fn.expand("%")
            local arch = vim.fn.input("GPU arch (e.g., sm_75): ", "sm_75")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal nvcc -arch=" .. arch .. " -o " .. out .. " " .. file)
          end, "Compile (specify arch)")

          -- Run
          map("<leader>cr", function()
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal ./" .. out)
          end, "Run")

          map("<leader>cR", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal nvcc -o " .. out .. " " .. file .. " && ./" .. out)
          end, "Compile & Run")

          -- PTX generation
          map("<leader>Cp", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r") .. ".ptx"
            vim.cmd("split | terminal nvcc -ptx -o " .. out .. " " .. file)
          end, "Generate PTX")

          map("<leader>cP", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r") .. ".cubin"
            vim.cmd("split | terminal nvcc -cubin -o " .. out .. " " .. file)
          end, "Generate CUBIN")

          -- SASS (GPU assembly)
          map("<leader>cs", function()
            local cubin = vim.fn.expand("%:r") .. ".cubin"
            vim.cmd("split | terminal cuobjdump -sass " .. cubin)
          end, "Disassemble SASS")

          -- Profiling
          map("<leader>Cpr", function()
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal nvprof ./" .. out)
          end, "Profile (nvprof)")

          map("<leader>Cpn", function()
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal nsys profile ./" .. out)
          end, "Profile (nsys)")

          map("<leader>Cpc", function()
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal ncu ./" .. out)
          end, "Profile (ncu)")

          map("<leader>Cpv", function()
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal cuda-memcheck ./" .. out)
          end, "Memory Check")

          -- GPU Info
          map("<leader>ci", function()
            vim.cmd("split | terminal nvidia-smi")
          end, "GPU Info (nvidia-smi)")

          map("<leader>cI", function()
            vim.cmd("split | terminal nvidia-smi -q")
          end, "GPU Info (detailed)")

          map("<leader>cd", function()
            vim.cmd("split | terminal nvidia-smi --query-gpu=name,compute_cap,memory.total --format=csv")
          end, "GPU Device Info")

          -- CUDA samples/deviceQuery
          map("<leader>cq", function()
            vim.cmd("split | terminal deviceQuery")
          end, "Device Query")

          -- Library compilation
          map("<leader>cl", function()
            local file = vim.fn.expand("%")
            local out = vim.fn.expand("%:r") .. ".o"
            vim.cmd("split | terminal nvcc -c -o " .. out .. " " .. file)
          end, "Compile to Object")

          map("<leader>cL", function()
            local file = vim.fn.expand("%")
            local out = "lib" .. vim.fn.expand("%:r") .. ".a"
            vim.cmd("split | terminal nvcc -lib -o " .. out .. " " .. file)
          end, "Compile to Library")

          -- CMake
          map("<leader>cmb", function()
            vim.cmd("split | terminal mkdir -p build && cd build && cmake .. && make")
          end, "CMake Build")

          map("<leader>cmc", function()
            vim.cmd("split | terminal cd build && cmake ..")
          end, "CMake Configure")

          map("<leader>cmm", function()
            vim.cmd("split | terminal cd build && make -j$(nproc)")
          end, "Make (parallel)")

          -- Debugging
          map("<leader>cdb", function()
            local out = vim.fn.expand("%:r")
            vim.cmd("split | terminal cuda-gdb ./" .. out)
          end, "Debug (cuda-gdb)")

          -- Code generation templates
          map("<leader>cn", function()
            local name = vim.fn.input("Kernel name: ")
            if name ~= "" then
              local template = string.format([[
#include <cuda_runtime.h>
#include <stdio.h>

// Error checking macro
#define CUDA_CHECK(call) \
    do { \
        cudaError_t err = call; \
        if (err != cudaSuccess) { \
            fprintf(stderr, "CUDA error at %%s:%%d: %%s\n", \
                    __FILE__, __LINE__, cudaGetErrorString(err)); \
            exit(EXIT_FAILURE); \
        } \
    } while(0)

// Kernel
__global__ void %s(float* d_out, const float* d_in, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        d_out[idx] = d_in[idx] * 2.0f;  // Example operation
    }
}

int main() {
    const int N = 1024;
    const int SIZE = N * sizeof(float);

    // Host memory
    float *h_in, *h_out;
    h_in = (float*)malloc(SIZE);
    h_out = (float*)malloc(SIZE);

    // Initialize input
    for (int i = 0; i < N; i++) {
        h_in[i] = (float)i;
    }

    // Device memory
    float *d_in, *d_out;
    CUDA_CHECK(cudaMalloc(&d_in, SIZE));
    CUDA_CHECK(cudaMalloc(&d_out, SIZE));

    // Copy to device
    CUDA_CHECK(cudaMemcpy(d_in, h_in, SIZE, cudaMemcpyHostToDevice));

    // Launch kernel
    int threadsPerBlock = 256;
    int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;
    %s<<<blocksPerGrid, threadsPerBlock>>>(d_out, d_in, N);
    CUDA_CHECK(cudaGetLastError());
    CUDA_CHECK(cudaDeviceSynchronize());

    // Copy back to host
    CUDA_CHECK(cudaMemcpy(h_out, d_out, SIZE, cudaMemcpyDeviceToHost));

    // Verify results
    printf("First 10 results:\n");
    for (int i = 0; i < 10; i++) {
        printf("%%f * 2 = %%f\n", h_in[i], h_out[i]);
    }

    // Cleanup
    CUDA_CHECK(cudaFree(d_in));
    CUDA_CHECK(cudaFree(d_out));
    free(h_in);
    free(h_out);

    return 0;
}
]], name, name)

              local filename = name .. ".cu"
              local file = io.open(filename, "w")
              if file then
                file:write(template)
                file:close()
                vim.cmd("edit " .. filename)
                vim.notify("Created " .. filename, vim.log.levels.INFO)
              end
            end
          end, "New Kernel File")

          -- Shared memory kernel template
          map("<leader>cN", function()
            local name = vim.fn.input("Kernel name: ")
            if name ~= "" then
              local template = string.format([[
#include <cuda_runtime.h>
#include <stdio.h>

#define BLOCK_SIZE 256

#define CUDA_CHECK(call) \
    do { \
        cudaError_t err = call; \
        if (err != cudaSuccess) { \
            fprintf(stderr, "CUDA error at %%s:%%d: %%s\n", \
                    __FILE__, __LINE__, cudaGetErrorString(err)); \
            exit(EXIT_FAILURE); \
        } \
    } while(0)

// Kernel using shared memory
__global__ void %s(float* d_out, const float* d_in, int n) {
    __shared__ float shared_data[BLOCK_SIZE];

    int tid = threadIdx.x;
    int gid = blockIdx.x * blockDim.x + threadIdx.x;

    // Load to shared memory
    if (gid < n) {
        shared_data[tid] = d_in[gid];
    } else {
        shared_data[tid] = 0.0f;
    }
    __syncthreads();

    // Process in shared memory
    // Example: simple reduction within block
    for (int stride = blockDim.x / 2; stride > 0; stride >>= 1) {
        if (tid < stride && gid + stride < n) {
            shared_data[tid] += shared_data[tid + stride];
        }
        __syncthreads();
    }

    // Write result
    if (tid == 0) {
        d_out[blockIdx.x] = shared_data[0];
    }
}

int main() {
    const int N = 1024;
    const int SIZE = N * sizeof(float);

    float *h_in, *h_out;
    h_in = (float*)malloc(SIZE);

    int numBlocks = (N + BLOCK_SIZE - 1) / BLOCK_SIZE;
    h_out = (float*)malloc(numBlocks * sizeof(float));

    for (int i = 0; i < N; i++) {
        h_in[i] = 1.0f;
    }

    float *d_in, *d_out;
    CUDA_CHECK(cudaMalloc(&d_in, SIZE));
    CUDA_CHECK(cudaMalloc(&d_out, numBlocks * sizeof(float)));
    CUDA_CHECK(cudaMemcpy(d_in, h_in, SIZE, cudaMemcpyHostToDevice));

    %s<<<numBlocks, BLOCK_SIZE>>>(d_out, d_in, N);
    CUDA_CHECK(cudaGetLastError());
    CUDA_CHECK(cudaDeviceSynchronize());

    CUDA_CHECK(cudaMemcpy(h_out, d_out, numBlocks * sizeof(float), cudaMemcpyDeviceToHost));

    float total = 0.0f;
    for (int i = 0; i < numBlocks; i++) {
        total += h_out[i];
    }
    printf("Sum: %%f (expected: %%d)\n", total, N);

    CUDA_CHECK(cudaFree(d_in));
    CUDA_CHECK(cudaFree(d_out));
    free(h_in);
    free(h_out);

    return 0;
}
]], name, name)

              local filename = name .. "_shared.cu"
              local file = io.open(filename, "w")
              if file then
                file:write(template)
                file:close()
                vim.cmd("edit " .. filename)
                vim.notify("Created " .. filename, vim.log.levels.INFO)
              end
            end
          end, "New Shared Memory Kernel")

          -- Thrust template
          map("<leader>ct", function()
            local template = [[
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/transform.h>
#include <thrust/reduce.h>
#include <thrust/sort.h>
#include <iostream>

struct square_functor {
    __host__ __device__
    float operator()(const float& x) const {
        return x * x;
    }
};

int main() {
    const int N = 1024;

    // Host vector
    thrust::host_vector<float> h_vec(N);
    for (int i = 0; i < N; i++) {
        h_vec[i] = (float)i;
    }

    // Device vector (automatic copy)
    thrust::device_vector<float> d_vec = h_vec;
    thrust::device_vector<float> d_result(N);

    // Transform
    thrust::transform(d_vec.begin(), d_vec.end(), d_result.begin(), square_functor());

    // Reduce
    float sum = thrust::reduce(d_result.begin(), d_result.end(), 0.0f, thrust::plus<float>());
    std::cout << "Sum of squares: " << sum << std::endl;

    // Sort
    thrust::sort(d_vec.begin(), d_vec.end());

    // Copy back
    thrust::copy(d_result.begin(), d_result.begin() + 10, std::ostream_iterator<float>(std::cout, " "));
    std::cout << std::endl;

    return 0;
}
]]
            local file = io.open("thrust_example.cu", "w")
            if file then
              file:write(template)
              file:close()
              vim.cmd("edit thrust_example.cu")
              vim.notify("Created thrust_example.cu", vim.log.levels.INFO)
            end
          end, "New Thrust Example")

          -- Code actions
          map("<leader>ch", function()
            vim.lsp.buf.hover()
          end, "Hover Info")

          map("<leader>caa", function()
            vim.lsp.buf.code_action()
          end, "Code Actions")

          -- Switch between .cu and .cuh
          map("<leader>co", function()
            local file = vim.fn.expand("%")
            local ext = vim.fn.expand("%:e")
            local base = vim.fn.expand("%:r")
            if ext == "cu" then
              vim.cmd("edit " .. base .. ".cuh")
            elseif ext == "cuh" then
              vim.cmd("edit " .. base .. ".cu")
            end
          end, "Switch .cu/.cuh")
        end,
      })
    end,
  },
}
