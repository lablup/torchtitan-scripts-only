#!/usr/bin/env python3
"""
Download a sample of HuggingFaceFW/fineweb-edu dataset for testing purposes.
Saves to tests/assets/c4_test directory (compatible with c4_test DatasetConfig).
"""

from datasets import load_dataset
import os

def download_fineweb_edu(output_dir: str = "tests/assets/c4_test", num_samples: int = 1_000_000):
    """
    Download a sample of fineweb-edu dataset and save it locally.

    Args:
        output_dir: Directory to save the dataset
        num_samples: Number of samples to download (default: 1,000,000)
    """
    print(f"Downloading {num_samples:,} samples from HuggingFaceFW/fineweb-edu...")

    # Load streaming dataset to avoid downloading everything
    dataset = load_dataset(
        "HuggingFaceFW/fineweb-edu",
        "sample-10BT",  # Use the 10B token sample subset
        split="train",
        streaming=True,
        trust_remote_code=True,
    )

    # Take only the specified number of samples
    samples = []
    for i, sample in enumerate(dataset):
        if i >= num_samples:
            break
        samples.append(sample)
        if (i + 1) % 100_000 == 0:
            print(f"Downloaded {i + 1:,}/{num_samples:,} samples...")

    print(f"Downloaded {len(samples):,} samples")

    # Convert to a proper Dataset object and save
    from datasets import Dataset
    test_dataset = Dataset.from_list(samples)

    # Save the dataset as parquet
    os.makedirs(output_dir, exist_ok=True)
    test_dataset.to_parquet(os.path.join(output_dir, "data.parquet"))

    print(f"Dataset saved to {output_dir}")
    print(f"Dataset info: {test_dataset}")
    print(f"\nSample entry keys: {list(test_dataset[0].keys())}")
    print(f"Sample text preview: {test_dataset[0]['text'][:500]}...")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Download fineweb-edu test dataset")
    parser.add_argument("--output-dir", default="tests/assets/c4_test", help="Output directory")
    parser.add_argument("--num-samples", type=int, default=1_000_000, help="Number of samples to download")
    args = parser.parse_args()

    download_fineweb_edu(args.output_dir, args.num_samples)
